import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/bullet_list.dart';

class DeleteProfile extends StatelessWidget {
  const DeleteProfile({super.key});

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
                'All your synchronised data/activities will be deleted.',
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
          const SizedBox(height: 32),
          Text(
            'Enter Your Password',
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
          const SizedBox(height: 16),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Permanantly Delete'),
          )
        ],
      ),
    );
  }
}
