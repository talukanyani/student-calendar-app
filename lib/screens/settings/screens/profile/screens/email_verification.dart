import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  Timer? resendTimer;
  Timer? checkVerificationTimer;
  int resendCountdown = 30;
  bool isVerified = false;

  void startResendTimer() {
    int counter = 30;

    resendTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() => resendCountdown = counter);
        counter--;
        if (counter < 0) timer.cancel();
      },
    );
  }

  void checkEmailVerified() {
    Future.delayed(
      Duration.zero,
      () {
        final authProvider =
            Provider.of<AuthenticationController>(context, listen: false);
        int counter = 0;

        checkVerificationTimer = Timer.periodic(
          const Duration(seconds: 5),
          (timer) {
            counter += 5;

            if (counter > 300) goNext(context);

            if (isVerified) timer.cancel();

            authProvider.checkEmailVerified().then((result) {
              setState(() => isVerified = result);
            });
          },
        );
      },
    );
  }

  void goNext(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void initState() {
    startResendTimer();
    checkEmailVerified();
    super.initState();
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    checkVerificationTimer?.cancel();
    super.dispose();
  }

  Widget verifyBody(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);
    final email =
        authProvider.currentUser?.email ?? 'email address you have used';

    String text =
        resendCountdown == 0 ? 'resend' : 'You can resend in $resendCountdown';

    onResendPressed() {
      authProvider.sendVerificationEmail();
      startResendTimer();
    }

    return Column(
      children: [
        Text(
          'Verification email was sent to $email. Make use of that email to verify your email address.',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Waiting for verification...',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 64),
        Column(
          children: [
            Text(
              'If you did not receive verification email, $text.',
              style: const TextStyle(fontSize: 14),
            ),
            ForegroundBorderBtn(
              onPressed: resendCountdown == 0 ? onResendPressed : null,
              child: const Text('Resend'),
            ),
          ],
        ),
      ],
    );
  }

  Widget verifiedBody(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Icon(
              Iconsax.tick_circle,
              size: 48,
              color: CustomColorScheme.success1,
            ),
            const SizedBox(height: 16),
            Text(
              'Email Was Successfully Verified',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        const SizedBox(height: 64),
        Row(
          children: [
            Expanded(
              child: ForegroundFilledBtn(
                onPressed: () => goNext(context),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Email Verification',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 48),
          isVerified ? verifiedBody(context) : verifyBody(context),
        ],
      ),
    );
  }
}
