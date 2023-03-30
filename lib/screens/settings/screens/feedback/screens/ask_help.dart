import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../modals/login_alert.dart';
import '../modals/verify_alert.dart';
import 'send_response.dart';

class AskHelpScreen extends StatefulWidget {
  const AskHelpScreen({super.key});

  @override
  State<AskHelpScreen> createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends State<AskHelpScreen> {
  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _send(BuildContext context) {
    CloudDatabase().sendHelp(
      _inputController.text.trim(),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const SendResponseScreen(
        sendName: 'help',
        message: Text(
          'We will respond to your help by '
          'emailing you using your profile\'s email address.',
        ),
      );
    }));
  }

  @override
  void dispose() {
    _inputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationController>(context).currentUser;
    var isLoggedIn = user != null;
    var isEmailVerified = user?.emailVerified ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _inputController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              maxLines: 6,
              maxLength: 500,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Explain your problem.';
                } else if (value.length < 30) {
                  return 'Explain your problem further.';
                } else {
                  return null;
                }
              },
              style: const TextStyle(letterSpacing: 1),
              decoration: const InputDecoration(
                hintText: 'Ask for a solution here..',
              ),
            ),
          ),
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!isLoggedIn) {
                  Show.modal(
                    context,
                    modal: const LoginAlert(sendName: 'help'),
                  );
                  return;
                }

                if (!isEmailVerified) {
                  Show.modal(
                    context,
                    modal: const VerifyAlert(sendName: 'help'),
                  );
                  return;
                }

                _send(context);
              }
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}