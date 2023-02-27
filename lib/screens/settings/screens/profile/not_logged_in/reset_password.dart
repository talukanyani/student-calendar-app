import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/alerts.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? _errorMessage;

  final _emailInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _resetPassword(BuildContext context) {
    Show.loading(context);

    Provider.of<AuthenticationController>(context, listen: false)
        .resetPassword(_emailInputController.text)
        .then((status) {
      Hide.loading(context);

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
            _errorMessage = 'There was an error while reseting your password.';
          });
          break;
        default:
          Navigator.pop(context);
          Show.modal(
            context,
            modal: const InfoAlert(
              title: Text('Email Sent'),
              content: Text(
                'Email with password reset link was sent. Go to change password on that link then come back here to log in with new password.\n\nIf you didn\'t recieve the email you may try again.',
              ),
            ),
          );
      }
    });
  }

  @override
  void dispose() {
    _emailInputController.clear();
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
            'Reset Password',
            style: Theme.of(context).textTheme.headline4,
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
              style: const TextStyle(fontSize: 20),
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
                _resetPassword(context);
              }
            },
            child: const Text('Reset'),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ],
      ),
    );
  }
}
