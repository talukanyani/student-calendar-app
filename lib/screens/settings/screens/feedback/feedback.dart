import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'screens/ask_help.dart';
import 'screens/bug_report.dart';
import 'screens/suggestion.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget button({
      required void Function() onPressed,
      required Text title,
      required Icon icon,
    }) {
      return Row(
        children: [
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: CustomColorScheme.grey4,
            ),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 8),
                title,
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enjoying this app?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          button(
            onPressed: () {},
            title: Text(
              'Rate it on '
              '${Platform.isAndroid ? 'Play Store' : 'App Store'}',
            ),
            icon: const Icon(Icons.star_outline),
          ),
          button(
            onPressed: () {},
            title: const Text('Share with friends'),
            icon: const Icon(Icons.share_outlined),
          ),
          const SizedBox(height: 32),
          Text(
            'Need a help?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          button(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AskHelpScreen()),
              );
            },
            title: const Text('Ask for help'),
            icon: const Icon(Icons.help_outline),
          ),
          const SizedBox(height: 32),
          Text(
            'Something not working?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          button(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BugReportScreen(),
                ),
              );
            },
            title: const Text('Rebort a bug'),
            icon: const Icon(Icons.bug_report_outlined),
          ),
          const SizedBox(height: 32),
          Text(
            'Have a suggestion?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 8),
          button(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SuggestionScreen(),
                ),
              );
            },
            title: const Text('Send a suggestion'),
            icon: const Icon(Icons.feedback_outlined),
          ),
        ],
      ),
    );
  }
}
