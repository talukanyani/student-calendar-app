import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'screens/profile/profile.dart';
import 'screens/synchronisation/synchronisation.dart';
import 'screens/personalisation/personalisation.dart';
import 'screens/feedback/feedback.dart';
import 'screens/about/about.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        primary: false,
        children: const [
          ProfileTile(),
          Tile(
            title: 'Synchronisation Settings',
            subtitle: 'Synchronise your data',
            icon: FluentIcons.cloud_32_filled,
            page: SynchronisationSettings(),
          ),
          Tile(
            title: 'App Settings',
            subtitle: 'Personalise this app',
            icon: FluentIcons.settings_32_filled,
            page: AppSettings(),
          ),
          Tile(
            title: 'Feedback',
            icon: FluentIcons.person_feedback_24_filled,
            page: FeedbackScreen(),
          ),
          Tile(
            title: 'About',
            icon: FluentIcons.info_24_filled,
            page: AboutScreen(),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.title,
    required this.icon,
    required this.page,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return RectContainer(
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => page),
        ),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        leading: Column(
          children: [
            const Spacer(),
            Icon(
              icon,
              size: subtitle == null ? 24 : 32,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return RectContainer(
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ProfileSettings()),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                FluentIcons.person_circle_32_filled,
                size: 48,
                color: CustomColorScheme.grey3,
              ),
              Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Manage your profile',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
