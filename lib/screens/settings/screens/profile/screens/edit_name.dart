import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/buttons.dart';
import '../widgets/bullet_list.dart';

class EditName extends StatelessWidget {
  const EditName({super.key});

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Name')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Note that if you edit name:',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          const BulletList(
            texts: [
              Text('You won\'t be able to edit name again until next 7 days.'),
            ],
          ),
          const SizedBox(height: 32),
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
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
