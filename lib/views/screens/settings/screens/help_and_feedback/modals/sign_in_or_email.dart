import 'package:flutter/material.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/modal.dart';

import '../../account/sign_in.dart';

class SignInOrEmailModal extends StatelessWidget {
  const SignInOrEmailModal({super.key, required this.sendName});

  final String sendName;

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text('Sign In / Email', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        Text(
          'To send us a $sendName, you have to sign in.'
          ' Alternatively, you can email us your $sendName.',
        ),
        const SizedBox(height: 16),
        ForegroundFilledBtn(
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
          },
          child: const Text('Sign In'),
        ),
        const SizedBox(height: 4),
        ForegroundBorderBtn(
          onPressed: () => Helpers.launchLink('mailto:muts.dev@outlook.com'),
          child: const Text('Email Us'),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
