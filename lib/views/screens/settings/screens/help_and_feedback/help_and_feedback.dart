import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:sc_app/utils/helpers.dart';

import 'screens/ask_help.dart';
import 'screens/bug_report.dart';
import 'screens/suggestion.dart';

class HelpAndFeedbackScreen extends StatelessWidget {
  const HelpAndFeedbackScreen({super.key});

  void _redirectToRateApp() {
    const packageName = 'com.example.sc_app';
    const appStoreId = '';

    if (Platform.isAndroid) {
      Helpers.launchLink('market://details?id=$packageName').then((isLaunched) {
        if (!isLaunched) {
          Helpers.launchLink(
            'https://play.google.com/store/apps/details?id=$packageName',
          );
        }
      });
    }

    if (Platform.isIOS) {
      Helpers.launchLink('https://apps.apple.com/app/id$appStoreId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Feedback')),
      body: ListView(
        primary: false,
        children: [
          ListTile(
            onTap: _redirectToRateApp,
            title: const Text('Rate'),
            subtitle: Text(
              'Rate and review this app on '
              '${Platform.isAndroid ? 'Play Store' : 'App Store'}',
            ),
            leading: const Column(
              children: [Spacer(), Icon(Icons.star), Spacer()],
            ),
            visualDensity: const VisualDensity(vertical: -3),
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
