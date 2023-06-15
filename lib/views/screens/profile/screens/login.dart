import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_formatter.dart';
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/loading.dart';
import 'create_profile.dart';
import 'reset_password.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .login(
          email: _emailInputController.text,
          password: _passwordInputController.text,
        )
        .then((status) {
      setState(() => _isLoading = false);

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
          onDone();
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
    if (_isLoading) {
      return const Loading(
        text: 'Please wait while we log you in...',
      );
    }

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
                _login(onDone: () => Navigator.pop(context));
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
