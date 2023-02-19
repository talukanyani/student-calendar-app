import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/alerts.dart';
import '../widgets/loading.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? errorMessage;

  static final _emailInputController = TextEditingController();

  resetPassword(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    showLoading(context);

    authProvider
        .resetPassword(
      _emailInputController.text,
    )
        .then((value) {
      hideLoading(context);

      switch (value) {
        case AuthStatus.profileNotFound:
          setState(() {
            errorMessage = 'There is no profile for this email.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while reseting your password.';
          });
          break;
        default:
          Navigator.pop(context);
          showModal(
            context,
            modal: showModal(
              context,
              modal: const InfoAlert(
                title: Text('Email Sent'),
                content: Text(
                  'Email with password reset link was sent. Go to change password on that link then come back here to log in with new password.\n\nIf you didn\'t recieve the email you may try again.',
                ),
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
          TextField(
            controller: _emailInputController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 50,
            inputFormatters: [noSpace()],
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Email',
              counterText: '',
            ),
            onTap: () {
              setState(() => errorMessage = null);
            },
          ),
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              resetPassword(context);
            },
            child: const Text('Reset'),
          ),
          SizedBox(height: errorMessage == null ? 0 : 4),
          Text(
            errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ],
      ),
    );
  }
}
