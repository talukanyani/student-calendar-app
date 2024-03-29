import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/loading.dart';

import '../modals/sign_in_or_email.dart';
import 'send_response.dart';

class AskHelpScreen extends ConsumerStatefulWidget {
  const AskHelpScreen({super.key});

  @override
  ConsumerState<AskHelpScreen> createState() => _AskHelpScreenState();
}

class _AskHelpScreenState extends ConsumerState<AskHelpScreen> {
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _send() {
    setState(() => _isLoading = true);

    CloudDb()
        .sendHelp(_inputController.text.trim(), user: ref.watch(userProvider))
        .then(
      (_) {
        setState(() => _isLoading = false);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SendResponseScreen(
              sendName: 'help',
              message: Text(
                'We will respond to your help by '
                'emailing you using your profile\'s email address.',
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _inputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    if (_isLoading) return const Loading(text: 'Sending...');

    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: ListView(
        primary: false,
        padding: (availWidth < 480)
            ? const EdgeInsets.all(16)
            : EdgeInsets.symmetric(
                horizontal: ((availWidth - 480) / 2) + 16,
                vertical: 16,
              ),
        children: [
          Text(
            'You don\'t know how something works? We know how, ask us.',
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
              final isLoggedIn = ref.watch(userProvider) != null;

              if (!_formKey.currentState!.validate()) return;

              if (!isLoggedIn) {
                showDialog(
                  context: context,
                  builder: (context) => const SignInOrEmailModal(
                    sendName: 'help',
                  ),
                );
                return;
              }

              _send();
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
