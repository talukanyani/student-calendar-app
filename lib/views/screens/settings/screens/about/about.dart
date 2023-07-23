import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/tile_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const appVersion = '1.1.0';

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        primary: false,
        padding: (availWidth < 480)
            ? const EdgeInsets.all(16)
            : EdgeInsets.symmetric(
                horizontal: ((availWidth - 480) / 2) + 16,
                vertical: 16,
              ),
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
          const SizedBox(height: 24),
          TileButton(
            title: const Text('Share this app'),
            leading: const Icon(Iconsax.share),
            onTap: () => Share.share(
              'Checkout this mobile app called Student Calendar. '
              'It helps with managing your assessments/activities. '
              'Download it at https://muts.dev/student_calendar/download',
              subject: 'Student Calendar App',
            ),
          ),
          TileButton(
            title: const Text('Terms of Use'),
            leading: const Icon(Iconsax.document),
            onTap: () => Helpers.launchLink('https://muts.dev/terms'),
          ),
          TileButton(
            title: const Text('Privacy Policy'),
            leading: const Icon(Iconsax.document),
            onTap: () => Helpers.launchLink('https://muts.dev/privacy'),
          ),
          const SizedBox(height: 32),
          Text(
            'Copyright \u00A9 ${DateTime.now().year} '
            'Muts. All rights are reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
