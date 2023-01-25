import 'package:flutter/material.dart';
import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/themes/color_scheme.dart';
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
              Text(
                'You won\'t be able to create new profile using $email in the next 30 days.',
              ),
              Text(
                  'You won\'t be able to change another profile\'s email to $email in the next 30 days.'),
              Text(
                'You will lose all your back ups.',
                style: TextStyle(color: Theme.of(context).errorColor),
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
          const SizedBox(height: 16),
          Text(
            'Enter Password',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColorScheme.grey4,
            ),
          ),
          const SizedBox(height: 4),
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
          ElevatedButton(
            onPressed: () {
              showModal(
                context,
                modal: SecurityCode(
                  email: email,
                  actionName: 'delete',
                ),
              );
            },
            style: ElevatedButton.styleFrom(elevation: 0),
            child: const Text('Permanantly Delete'),
          )
        ],
      ),
    );
  }
}
