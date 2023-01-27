import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Student Calendar By Tmlab',
            style: Theme.of(context).textTheme.headline6,
          ),
          const Text('Version 1.0.0'),
          const SizedBox(height: 32),
          Text(
            '\u00A9 ${DateTime.now().year} Tmlab. All rights are reserved.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Terms of use',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Privacy Police',
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
