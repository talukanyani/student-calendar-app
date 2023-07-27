import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/loading.dart';

import '../modals/sign_in_or_email.dart';
import 'send_response.dart';

class SuggestionScreen extends ConsumerStatefulWidget {
  const SuggestionScreen({super.key});

  @override
  ConsumerState<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends ConsumerState<SuggestionScreen> {
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _send() {
    setState(() => _isLoading = true);

    CloudDb()
        .sendSuggestion(
      _inputController.text.trim(),
      user: ref.watch(userProvider),
    )
        .then((_) {
      setState(() => _isLoading = false);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SendResponseScreen(
            sendName: 'suggestion',
            message: Text(
              'Thank you so much for your suggestion. '
              'Your suggestion helps us improve.',
            ),
          ),
        ),
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
    final availWidth = MediaQuery.of(context).size.width;

    if (_isLoading) return const Loading(text: 'Sending...');

    return Scaffold(
      appBar: AppBar(title: const Text('Send Suggestion')),
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
            'Something not functioning the way you want? Send us a suggestion.',
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
                  return 'Write your suggestion';
                } else if (value.length < 30) {
                  return 'Further explain your suggestion.';
                } else {
                  return null;
                }
              },
              style: const TextStyle(letterSpacing: 1),
              decoration: const InputDecoration(
                hintText: 'Write your suggestion here..',
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
                    sendName: 'suggestion',
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
