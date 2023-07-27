import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'screens/about/about.dart';
import 'screens/help_and_feedback/help_and_feedback.dart';
import 'widgets/account.dart';
import 'widgets/activities_sync.dart';
import 'widgets/preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    Widget title({required String text}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        primary: false,
        padding: (availWidth < 720)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: ((availWidth - 720) / 2)),
        children: [
          const Account(),
          title(text: 'Preferences'),
          const Preferences(),
          title(text: 'Sync'),
          const ActivitiesSync(),
          title(text: 'App'),
          ListTile(
            title: const Text('Help & Feedback'),
            leading: const Icon(FluentIcons.person_feedback_24_filled),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HelpAndFeedbackScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('About'),
            leading: const Icon(FluentIcons.info_24_filled),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
