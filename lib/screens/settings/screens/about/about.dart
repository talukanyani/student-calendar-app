import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/themes/color_scheme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  final appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    var grey = CustomColorScheme.grey4;

    Widget legalInfoBtn({required String label, required String url}) {
      return Row(
        children: [
          TextButton(
            onPressed: () => Helpers.lauchLink(url),
            style: TextButton.styleFrom(foregroundColor: grey),
            child: Row(
              children: [
                const Icon(Iconsax.document),
                const SizedBox(width: 8),
                Text(label),
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
                  color: grey,
                ),
          ),
          Text(
            'Version $appVersion',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: grey,
                ),
          ),
          const SizedBox(height: 32),
          legalInfoBtn(
            label: 'Terms of Use',
            url: 'https://tmlab.tech/terms',
          ),
          legalInfoBtn(
            label: 'Privacy Policy',
            url: 'https://tmlab.tech/privacy',
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
