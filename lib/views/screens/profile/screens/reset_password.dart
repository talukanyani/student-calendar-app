import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_formatter.dart';
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/loading.dart';

import 'reset_password_response.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key, this.email});

  final String? email;

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  String? _errorMessage;
  bool _isLoading = false;

  final _emailInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _resetPassword({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .resetPassword(_emailInputController.text)
        .then((status) {
      setState(() => _isLoading = false);

      switch (status) {
        case AuthStatus.profileNotFound:
          setState(() {
            _errorMessage = 'There is no profile for this email.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            _errorMessage = 'An error occurred.';
          });
          break;
        default:
          onDone();
      }
    });
  }

  @override
  void initState() {
    _emailInputController.text = widget.email ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _emailInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Loading();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Reset Password',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _emailInputController,
              keyboardType: TextInputType.emailAddress,
              maxLength: 50,
              inputFormatters: [InputFormatter.noSpace()],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your email.';
                } else if (!InputValidator.isValidEmail(value)) {
                  return 'Enter a valid email.';
                } else {
                  return null;
                }
              },
              style: const TextStyle(letterSpacing: 1),
              decoration: const InputDecoration(
                hintText: 'Email',
                counterText: '',
              ),
              onTap: () {
                setState(() => _errorMessage = null);
              },
            ),
          ),
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => _errorMessage = null);
              if (_formKey.currentState!.validate()) {
                _resetPassword(
                  onDone: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordResponseScreen(),
                    ),
                  ),
                );
              }
            },
            child: const Text('Reset'),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }
}
