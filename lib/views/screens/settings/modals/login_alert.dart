import 'package:flutter/material.dart';
import 'package:sc_app/views/screens/profile/screens/create_profile.dart';
import 'package:sc_app/views/screens/profile/screens/login.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/modal.dart';

class LoginAlert extends StatelessWidget {
  const LoginAlert({super.key, this.message});

  final Widget? message;

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text('Log In', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        message ?? const SizedBox(),
        SizedBox(height: (message == null) ? 0 : 16),
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
