import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../../profile/logged_in/email_verification.dart';

class VerifyAlert extends StatelessWidget {
  const VerifyAlert({super.key, required this.sendName});

  final String sendName;

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
          'To send us a $sendName, you have to complete your profile.'
          'Verify that you have access to $email',
        ),
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
            authProvider.sendVerificationEmail();
            Navigator.pop(context);
            Navigator.of(context).push(
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
