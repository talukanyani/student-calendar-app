import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/loading.dart';
import '../../../modals/login_alert.dart';
import '../widgets/login_message.dart';
import 'send_response.dart';

class BugReportScreen extends ConsumerStatefulWidget {
  const BugReportScreen({super.key});

  @override
  ConsumerState<BugReportScreen> createState() => _BugReportScreenState();
}

class _BugReportScreenState extends ConsumerState<BugReportScreen> {
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _send(BuildContext context) {
    setState(() => _isLoading = true);

    CloudDb()
        .sendBugReport(_inputController.text.trim(),
            user: ref.watch(authProvider))
        .then((_) {
      setState(() => _isLoading = false);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const SendResponseScreen(
            sendName: 'bug report',
            message: Text(
              'Thank you so much for your bug report. '
              'We will fix this problem as soon as possible.',
            ),
          );
        }),
      );
    });
  }

  @override
  void dispose() {
    _inputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Loading(text: 'Sending...');

    return Scaffold(
      appBar: AppBar(title: const Text('Report Bug')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Something not working or crashing? '
            'We didn\'t notice that. Please let us know.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
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
              if (!_formKey.currentState!.validate()) return;
              if (!ref.watch(isLoggedInProvider)) {
                showDialog(
                  context: context,
                  builder: (context) => const LoginAlert(
                    message: LoginMessage(sendName: 'bug report'),
                  ),
                );
                return;
              }

              _send(context);
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
