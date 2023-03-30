import 'package:flutter/material.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../../profile/not_logged_in/create_profile.dart';
import '../../profile/not_logged_in/login.dart';

class LoginAlert extends StatelessWidget {
  const LoginAlert({super.key, required this.sendName});

  final String sendName;

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'We can not identify you',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text('To send us a $sendName, you have to log in with your profile.'),
        RichText(
          text: TextSpan(
            text: 'Alternatively, you can',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              WidgetSpan(
                child: InlineBtn(
                  onPressed: () => Helpers.lauchLink(
                    'mailto:tmlab.tech@hotmail.com',
                  ),
                  label: 'email us',
                ),
              ),
              TextSpan(text: 'your $sendName.'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ForegroundFilledBtn(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const Text('Log In'),
        ),
        ForegroundBorderBtn(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateProfileScreen(),
              ),
            );
          },
          child: const Text('Create Profile'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
