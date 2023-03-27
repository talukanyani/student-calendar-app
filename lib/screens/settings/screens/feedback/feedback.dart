import 'dart:io' show Platform;
import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'screens/bug.dart';
import 'screens/suggestion.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enjoying this app?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          FeedbackButton(
            onPressed: () {},
            text:
                'Rate it on ${Platform.isAndroid ? 'Play Store' : 'App Store'}',
            icon: Icons.star,
          ),
          FeedbackButton(
            onPressed: () {},
            text: 'Share with friends',
            icon: Icons.share,
          ),
          const SizedBox(height: 32),
          Text(
            'Something not working?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          FeedbackButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BugScreen()),
              );
            },
            text: 'Rebort a bug',
            icon: Icons.bug_report,
          ),
          const SizedBox(height: 32),
          Text(
            'Not satisfying?',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          FeedbackButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuggestionScreen(),
                ),
              );
            },
            text: 'Send a suggestion',
            icon: Icons.feedback,
          ),
        ],
      ),
    );
  }
}

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: CustomColorScheme.background5,
          ),
          child: Row(
            children: [
              Text(text),
              const SizedBox(width: 8),
              Icon(icon),
            ],
          ),
        ),
      ],
    );
  }
}
