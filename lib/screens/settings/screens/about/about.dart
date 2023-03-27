import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var largeBodyText = Theme.of(context).textTheme.titleSmall;

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Student Calendar By Tmlab',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text('Version 1.0.0', style: largeBodyText),
          const SizedBox(height: 32),
          Text(
            '\u00A9 ${DateTime.now().year} Tmlab. All rights are reserved.',
            style: largeBodyText,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Terms of use',
                style: largeBodyText?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Privacy Police',
                style: largeBodyText?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
