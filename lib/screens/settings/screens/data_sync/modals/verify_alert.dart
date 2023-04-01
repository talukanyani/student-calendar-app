import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../../profile/logged_in/email_verification.dart';

class VerifyAlert extends StatelessWidget {
  const VerifyAlert({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(
      context,
      listen: false,
    );
    var email = authProvider.currentUser?.email ?? 'your email';

    return Modal(
      children: [
        Text(
          'Verify Your Email',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'To turn on data sync, you have to complete your profile. '
          'Verify that you have access to $email',
        ),
        const SizedBox(height: 16),
        ForegroundFilledBtn(
          onPressed: () {
            authProvider.sendVerificationEmail();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const EmailVerificationScreen(),
              ),
            );
          },
          child: const Text('Verify Email'),
        ),
        ForegroundBorderBtn(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
