import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';

import 'email_verification.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  bool _isPasswordHidden = true;

  final _passwordInputController = TextEditingController();
  final _emailInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _changeEmail(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider
        .changeEmail(_passwordInputController.text, _emailInputController.text)
        .then((status) {
      Hide.loading(context);

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
          authProvider.sendVerificationEmail();
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Enter Your Password',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: CustomColorScheme.grey4,
                      ),
                ),
                const SizedBox(height: 8),
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
                  style: const TextStyle(fontSize: 20),
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
                Text(
                  'Enter New Email',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: CustomColorScheme.grey4,
                      ),
                ),
                const SizedBox(height: 8),
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
                  style: const TextStyle(fontSize: 20),
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
                _changeEmail(context);
              }
            },
            child: const Text('Change'),
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
