import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/loading.dart';
import '../modals/login_alert.dart';
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

  void _send(BuildContext context) {
    setState(() => _isLoading = true);

    CloudDb()
        .sendSuggestion(
      _inputController.text.trim(),
      user: ref.watch(authProvider),
    )
        .then((_) {
      setState(() => _isLoading = false);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return const SendResponseScreen(
            sendName: 'suggestion',
            message: Text(
              'Thank you so much for your suggestion. '
              'Your suggestion helps us improve.',
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
      appBar: AppBar(title: const Text('Send Suggestion')),
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
                  return 'Write your suggestion';
                } else if (value.length < 30) {
                  return 'Further expalain your suggestion.';
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
              if (!_formKey.currentState!.validate()) return;
              if (!ref.watch(isLoggedInProvider)) {
                Show.modal(
                  context,
                  modal: const LoginAlert(sendName: 'suggestion'),
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
