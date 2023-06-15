import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:sc_app/utils/helpers.dart';
import 'screens/ask_help.dart';
import 'screens/bug_report.dart';
import 'screens/suggestion.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: ListView(
        primary: false,
        children: [
          ListTile(
            onTap: () => Helpers.launchLink(
              'https://tmlab.tech/student_calendar/rate?platform='
              '${Platform.isAndroid ? 'playstore' : 'appstore'}',
            ),
            title: Text(
              'Rate and review this app on '
              '${Platform.isAndroid ? 'Play Store' : 'App Store'}',
            ),
            leading: const Icon(Icons.star),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AskHelpScreen()),
            ),
            title: const Text('Ask for help'),
            leading: const Icon(Icons.help),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const BugReportScreen()),
            ),
            title: const Text('Report a bug'),
            leading: const Icon(Icons.bug_report),
          ),
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SuggestionScreen()),
            ),
            title: const Text('Send a suggestion'),
            leading: const Icon(Icons.feedback),
          ),
        ],
      ),
    );
  }
}
