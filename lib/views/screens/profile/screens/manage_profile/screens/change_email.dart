import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_formatter.dart';
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/loading.dart';
import '../../email_verification.dart';

class ChangeEmailScreen extends ConsumerStatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  ConsumerState<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends ConsumerState<ChangeEmailScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  final _passwordInputController = TextEditingController();
  final _emailInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _changeEmail({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .changeEmail(
          password: _passwordInputController.text,
          newEmail: _emailInputController.text,
        )
        .then((status) {
      setState(() => _isLoading = false);

      switch (status) {
        case AuthStatus.emailInUse:
          setState(() {
            _emailErrorMessage = 'Email is already on an existing profile.';
          });
          break;
        case AuthStatus.wrongPassword:
          setState(() {
            _passwordErrorMessage = 'Password is incorrect.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            _errorMessage = 'There was an error while changing your email.';
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
        text: 'Please wait while we change your email...',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
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
                  label: 'Enter Your Password',
                  bottomPadding: 8,
                ),
                TextFormField(
                  controller: _passwordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required.';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isPasswordHidden,
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: _passwordErrorMessage,
                    counterText: '',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() => _isPasswordHidden = !_isPasswordHidden);
                      },
                      child: Icon(
                        _isPasswordHidden ? Iconsax.eye : Iconsax.eye_slash,
                        size: 20,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 48,
                    ),
                  ),
                  onTap: () {
                    setState(() => _passwordErrorMessage = null);
                  },
                ),
                const SizedBox(height: 16),
                const InputFieldLabel(
                  label: 'Enter New Email',
                  bottomPadding: 8,
                ),
                TextFormField(
                  controller: _emailInputController,
                  inputFormatters: [InputFormatter.noSpace()],
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a new email.';
                    } else if (!InputValidator.isValidEmail(value)) {
                      return 'Enter a valid email.';
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: _emailErrorMessage,
                    counterText: '',
                  ),
                  onTap: () {
                    setState(() => _emailErrorMessage = null);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => _errorMessage = null);
              if (_formKey.currentState!.validate()) {
                _changeEmail(
                  onDone: () {
                    ref.read(authProvider.notifier).sendVerificationEmail();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const EmailVerificationScreen(),
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
        ],
      ),
    );
  }
}
