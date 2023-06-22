import 'package:flutter/material.dart';
import 'package:sc_app/views/screens/profile/profile.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/modal.dart';

class SignInAlert extends StatelessWidget {
  const SignInAlert({super.key, this.message});

  final Widget? message;

  @override
  Widget build(BuildContext context) {
    return Modal(
      insetPadding: 32,
      children: [
        Text('Sign In', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        message ?? const SizedBox(),
        SizedBox(height: (message == null) ? 0 : 24),
        ForegroundFilledBtn(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          },
          child: const Text('Sign In'),
        ),
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
