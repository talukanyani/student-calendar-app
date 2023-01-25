import 'package:flutter/material.dart';

import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/themes/color_scheme.dart';

import '../modals/security_code.dart';
import '../widgets/bullet_list.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key, required this.email});

  final String email;

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Note That If You Change Email',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          BulletList(
            texts: [
              Text(
                'You won\'t be able to change back to $email in the next 30 days.',
              ),
              Text(
                'You won\'t be able to change another profile\'s email to $email in the next 30 days.',
              ),
              Text(
                'You wont be able to create new profile using $email in the next 30 days.',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Enter New Email',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColorScheme.grey4,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: inputController,
                  inputFormatters: [noSpace()],
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showModal(
                      context,
                      modal: SecurityCode(
                        email: email,
                        actionName: 'change',
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(elevation: 0),
                  child: const Text('Change'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
