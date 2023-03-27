import 'package:flutter/material.dart';
import 'package:sc_app/widgets/text_hyperlink.dart';

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
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'Version 1.0.0',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          Text(
            '\u00A9 ${DateTime.now().year} Tmlab. All rights are reserved.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TextHyperlink(
                text: 'Terms of use',
                textStyle: TextStyle(decoration: TextDecoration.underline),
                url: 'https://tmlab.tech/terms',
              ),
              SizedBox(height: 8),
              TextHyperlink(
                text: 'Privacy Policy',
                textStyle: TextStyle(decoration: TextDecoration.underline),
                url: 'https://tmlab.tech/privacy',
              ),
            ],
          )
        ],
      ),
    );
  }
}
