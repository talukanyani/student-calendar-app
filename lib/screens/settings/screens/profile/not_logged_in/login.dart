import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'create_profile.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  bool _isPasswordHidden = true;

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login(BuildContext context) {
    Show.loading(context);

    Provider.of<AuthenticationController>(context, listen: false)
        .login(_emailInputController.text, _passwordInputController.text)
        .then((status) {
      Hide.loading(context);

      switch (status) {
        case AuthStatus.profileNotFound:
          setState(() {
            _emailErrorMessage = 'There is no profile for this email.';
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
            _errorMessage = 'There was an error while logging you in.';
          });
          break;
        default:
          Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _emailInputController.clear();
    _passwordInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Log In',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  maxLength: 50,
                  inputFormatters: [InputFormatter.noSpace()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required.';
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
                const SizedBox(height: 16),
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => _errorMessage = null);
              if (_formKey.currentState!.validate()) {
                _login(context);
              }
            },
            child: const Text('Log In'),
          ),
          const SizedBox(height: 8),
          _errorMessage == null
              ? const SizedBox()
              : Text(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
                label: 'Reset Password',
              )
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 4,
            alignment: WrapAlignment.end,
            children: [
              const Text('Don\'t have a profile?'),
              InlineBtn(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const CreateProfileScreen(),
                    ),
                  );
                },
                label: 'Create Profile',
              )
            ],
          ),
        ],
      ),
    );
  }
}
