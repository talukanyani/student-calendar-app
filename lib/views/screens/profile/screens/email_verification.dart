import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/buttons.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
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
        int counter = 0;

        checkVerificationTimer = Timer.periodic(
          const Duration(seconds: 5),
          (timer) {
            counter += 5;

            if (counter > 300) goNext(context);

            if (isVerified) timer.cancel();

            ref.read(authProvider.notifier).checkEmailVerified().then((result) {
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
    final email = ref.watch(userProvider)?.email ?? 'your email address';

    return Column(
      children: [
        Text(
          'Verify that you have access to $email.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Waiting for verification...',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
        const SizedBox(height: 48),
        RichText(
          text: TextSpan(
              text: 'Verification email was sent to $email. '
                  'If you did not receive this email, ',
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                resendCountdown == 0
                    ? WidgetSpan(
                        child: InlineBtn(
                          label: 'resend',
                          onPressed: () {
                            ref
                                .read(authProvider.notifier)
                                .sendVerificationEmail();
                            startResendTimer();
                          },
                        ),
                      )
                    : TextSpan(
                        text: 'you can resend in $resendCountdown seconds.',
                      ),
              ]),
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
              color: context.successColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Email Was Successfully Verified',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const SizedBox(height: 48),
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
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Email Verification',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40),
          isVerified ? verifiedBody(context) : verifyBody(context),
        ],
      ),
    );
  }
}
