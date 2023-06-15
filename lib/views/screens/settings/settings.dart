import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/views/screens/profile/profile.dart';
import 'screens/data_sync/data_sync.dart';
import 'screens/preferences/preferences.dart';
import 'screens/feedback/feedback.dart';
import 'screens/about/about.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _tile({
    required String title,
    String? subtitle,
    required IconData icon,
    required void Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: Column(
        children: [
          const Spacer(),
          Icon(icon, size: subtitle == null ? 24 : 32),
          const Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        primary: false,
        children: [
          _tile(
            title: 'Profile',
            subtitle: 'Manage your profile',
            icon: FluentIcons.person_circle_32_filled,
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            ),
          ),
          _tile(
            title: 'Data Sync',
            subtitle: 'Auto sync/back up your data',
            icon: FluentIcons.cloud_32_filled,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DataSyncScreen(),
              ),
            ),
          ),
          _tile(
            title: 'Preferences',
            subtitle: 'Personalize this app',
            icon: FluentIcons.settings_32_filled,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PreferencesScreen(),
              ),
            ),
          ),
          _tile(
            title: 'Feedback',
            icon: FluentIcons.person_feedback_24_filled,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FeedbackScreen(),
              ),
            ),
          ),
          _tile(
            title: 'About',
            icon: FluentIcons.info_24_filled,
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
