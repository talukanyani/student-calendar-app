import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? _errorMessage;
  String? _oldPasswordErrorMessage;
  String? _newPasswordErrorMessage;

  bool _isOldPasswordHidden = true;
  bool _isNewPasswordHidden = true;

  final _oldPasswordInputController = TextEditingController();
  final _newPasswordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _changePassword(BuildContext context) {
    Show.loading(context);

    Provider.of<AuthenticationController>(context, listen: false)
        .changePassword(
      _oldPasswordInputController.text,
      _newPasswordInputController.text,
    )
        .then((status) {
      Hide.loading(context);

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
          Navigator.pop(context);
          Show.snackBar(
            context,
            text: 'Password was successfully changed.',
            snackBarIcon: SnackBarIcon.done,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Enter Old Password',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: CustomColorScheme.grey4,
                      ),
                ),
                const SizedBox(height: 8),
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
                  style: const TextStyle(fontSize: 20),
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
                Text(
                  'Enter New Password',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: CustomColorScheme.grey4,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _newPasswordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'New password is required.';
                    } else if (!InputValidator.isStrongPassword(value)) {
                      return 'New password is too weak.';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isNewPasswordHidden,
                  style: const TextStyle(fontSize: 20),
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
                _changePassword(context);
              }
            },
            child: const Text('Change Password'),
          ),
          const SizedBox(height: 4),
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ],
      ),
    );
  }
}
