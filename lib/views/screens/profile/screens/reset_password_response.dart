import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/buttons.dart';

class ResetPasswordResponseScreen extends StatelessWidget {
  const ResetPasswordResponseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              Icon(
                Iconsax.tick_circle,
                size: 48,
                color: context.successColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Password Reset Link Was Sent',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Email with password reset link was sent.'
            ' Make use of this link to reset your password.'
            '\n\nAfter resetting your password, come back here'
            ' to log in with your new password.'
            '\n\n\nIf you didn\'t receive the email, you may try again.',
          ),
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: ForegroundFilledBtn(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Log In'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
