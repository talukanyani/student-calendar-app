import 'package:flutter/material.dart';

import 'package:sc_app/helpers/show_modal.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/buttons.dart';
import '../modals/security_code.dart';
import '../widgets/bullet_list.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key, required this.email});

  final String email;

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Profile')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Note that if you delete your profile:',
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
                      text: 'You won\'t be able to create new profile using ',
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
              Text(
                'You will lose all your back ups.',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Your profile will be ',
                  style: TextStyle(color: Theme.of(context).errorColor),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'permanantly deleted,',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' and you won\'t be able to revert this action.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Enter Password',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: inputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Password',
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
                  actionName: 'delete',
                ),
              );
            },
            child: const Text('Permanantly Delete'),
          )
        ],
      ),
    );
  }
}
