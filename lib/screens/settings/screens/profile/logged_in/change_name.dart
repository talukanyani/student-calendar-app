import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Name')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enter New Name',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: inputController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            maxLength: 20,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Name',
              counterText: '',
            ),
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
