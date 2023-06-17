import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/loading.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

import '../../reset_password.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  String? _errorMessage;
  String? _oldPasswordErrorMessage;
  String? _newPasswordErrorMessage;
  bool _isOldPasswordHidden = true;
  bool _isNewPasswordHidden = true;
  bool _isLoading = false;

  final _oldPasswordInputController = TextEditingController();
  final _newPasswordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _changePassword({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .changePassword(
          oldPassword: _oldPasswordInputController.text,
          newPassword: _newPasswordInputController.text,
        )
        .then((status) {
      setState(() => _isLoading = false);

      switch (status) {
        case AuthStatus.weakPassword:
          setState(() {
            _newPasswordErrorMessage = 'New password is too weak.';
          });
          break;
        case AuthStatus.wrongPassword:
          setState(() {
            _oldPasswordErrorMessage = 'Old password is incorrect.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            _errorMessage = 'There was an error while changing your password.';
          });
          break;
        default:
          onDone();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading(
        text: 'Please wait while we change your password...',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InputFieldLabel(
                  label: 'Enter Old Password',
                  bottomPadding: 8,
                ),
                TextFormField(
                  controller: _oldPasswordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Old password is required.';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isOldPasswordHidden,
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Old Password',
                    errorText: _oldPasswordErrorMessage,
                    counterText: '',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isOldPasswordHidden = !_isOldPasswordHidden;
                        });
                      },
                      child: Icon(
                        _isOldPasswordHidden ? Iconsax.eye : Iconsax.eye_slash,
                        size: 20,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 48,
                    ),
                  ),
                  onTap: () {
                    setState(() => _oldPasswordErrorMessage = null);
                  },
                ),
                const SizedBox(height: 16),
                const InputFieldLabel(
                  label: 'Enter New Password',
                  bottomPadding: 8,
                ),
                TextFormField(
                  controller: _newPasswordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New password is required.';
                    } else if (!InputValidator.isStrongPassword(value)) {
                      return 'Password must be at least 6 characters,'
                          '\nand include at least one letter, number, and symbol';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isNewPasswordHidden,
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    errorText: _newPasswordErrorMessage,
                    counterText: '',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isNewPasswordHidden = !_isNewPasswordHidden;
                        });
                      },
                      child: Icon(
                        _isNewPasswordHidden ? Iconsax.eye : Iconsax.eye_slash,
                        size: 20,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 48,
                    ),
                  ),
                  onTap: () {
                    setState(() => _newPasswordErrorMessage = null);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => _errorMessage = null);
              if (_formKey.currentState!.validate()) {
                _changePassword(
                  onDone: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBar(
                        context,
                        text: 'Password was successfully changed.',
                        snackBarIcon: SnackBarIcon.done,
                      ),
                    );
                  },
                );
              }
            },
            child: const Text('Change'),
          ),
          const SizedBox(height: 4),
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 4,
            alignment: WrapAlignment.end,
            children: [
              const Text('Forgot password?'),
              InlineBtn(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(
                        email: ref.watch(userProvider)?.email,
                      ),
                    ),
                  );
                },
                label: 'Reset Password',
              )
            ],
          ),
        ],
      ),
    );
  }
}
