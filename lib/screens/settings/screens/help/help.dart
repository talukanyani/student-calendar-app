import 'package:flutter/material.dart';
import 'package:sc_app/widgets/buttons.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
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
            style: const TextStyle(letterSpacing: 1),
            decoration: const InputDecoration(
              hintText: 'Ask for a solution here..',
            ),
          ),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Send'),
          )
        ],
      ),
    );
  }
}
