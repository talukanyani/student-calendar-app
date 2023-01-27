import 'package:flutter/material.dart';
import 'package:sc_app/widgets/buttons.dart';

class BugScreen extends StatelessWidget {
  const BugScreen({super.key});

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Bug')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: inputController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 5,
            maxLength: 500,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Explain what went wrong...',
            ),
          ),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
