import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../modals/login_alert.dart';
import '../modals/verify_alert.dart';
import 'send_response.dart';

class BugReportScreen extends StatefulWidget {
  const BugReportScreen({super.key});

  @override
  State<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends State<BugReportScreen> {
  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _send(BuildContext context) {
    CloudDatabase().sendBugReport(
      _inputController.text.trim(),
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const SendResponseScreen(
        sendName: 'bug report',
        message: Text(
          'Thank you so much for your bug report. '
          'We will fix this problem as soon as possible.',
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
      appBar: AppBar(title: const Text('Report Bug')),
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
                  return 'Explain the problem.';
                } else if (value.length < 30) {
                  return 'Explain the problem further.';
                } else {
                  return null;
                }
              },
              style: const TextStyle(letterSpacing: 1),
              decoration: const InputDecoration(
                hintText: 'Explain what went wrong..',
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
                    modal: const LoginAlert(sendName: 'bug report'),
                  );
                  return;
                }

                if (!isEmailVerified) {
                  Show.modal(
                    context,
                    modal: const VerifyAlert(sendName: 'bug report'),
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
