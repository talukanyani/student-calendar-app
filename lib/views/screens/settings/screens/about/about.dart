import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/themes/color_scheme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    Widget button({
      required void Function() onPressed,
      required Text text,
      required Icon icon,
    }) {
      return Row(
        children: [
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(foregroundColor: context.grey4),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 8),
                text,
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Student Calendar',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: context.grey4,
                ),
          ),
          Text(
            'Version $appVersion',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: context.grey4,
                ),
          ),
          const SizedBox(height: 32),
          button(
            onPressed: () {
              Share.share(
                'Checkout this mobile app called Student Calendar, '
                'it helps with managing your assessments and activities. '
                'Download it at https://tmlab.tech/student_calendar/download',
                subject: 'Student Calendar App',
              );
            },
            text: const Text('Share this app'),
            icon: const Icon(Iconsax.share),
          ),
          button(
            onPressed: () => Helpers.launchLink('https://tmlab.tech/terms'),
            text: const Text('Terms of Use'),
            icon: const Icon(Iconsax.document),
          ),
          button(
            onPressed: () => Helpers.launchLink('https://tmlab.tech/privacy'),
            text: const Text('Privacy Policy'),
            icon: const Icon(Iconsax.document),
          ),
          const SizedBox(height: 32),
          Text(
            'Copyright \u00A9 ${DateTime.now().year} '
            'Tmlab. All rights are reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
