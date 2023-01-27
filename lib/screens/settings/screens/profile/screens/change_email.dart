import 'package:flutter/material.dart';

import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/buttons.dart';
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
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'You won\'t be able to change back to ',
                    ),
                    TextSpan(
                      text: email,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: ' in the next 14 days.')
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    const TextSpan(
                      text:
                          'You won\'t be able to change another profile\'s email to ',
                    ),
                    TextSpan(
                      text: email,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: ' in the next 14 days.')
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyText2,
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'You wont be able to create new profile using ',
                    ),
                    TextSpan(
                      text: email,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: ' in the next 14 days.')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Enter New Email',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
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
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {
              showModal(
                context,
                modal: SecurityCode(
                  email: email,
                  actionName: 'change',
                ),
              );
            },
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
