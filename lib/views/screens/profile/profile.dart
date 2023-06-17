import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/screens/settings/settings.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import 'package:sc_app/views/widgets/rect_container.dart';

import 'screens/create_profile.dart';
import 'screens/login.dart';
import 'screens/manage_profile/manage_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isLoggedIn = user != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        primary: false,
        children: [
          RectContainer(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(
                  FluentIcons.person_circle_32_filled,
                  size: 64,
                  color: context.grey3,
                ),
                const SizedBox(height: 8),
                Text(
                  isLoggedIn ? (user.displayName ?? 'Profile') : 'No Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                isLoggedIn
                    ? const LoggedInListTiles()
                    : const NotLoggedInListTiles(),
              ],
            ),
          ),
          RectContainer(
            child: Material(
              type: MaterialType.transparency,
              child: ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                ),
                title: const Text('Settings'),
                leading: const Icon(FluentIcons.settings_32_filled, size: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoggedInListTiles extends ConsumerWidget {
  const LoggedInListTiles({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ManageProfileScreen(),
              ),
            ),
            title: const Text('Manage Profile'),
            leading: const Icon(FluentIcons.person_accounts_24_filled),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => ConfirmationAlert(
                title: const Text('Log Out?'),
                content: const Text('Are you sure you want to log out?'),
                action: () {
                  ref.read(authProvider.notifier).logout();
                },
              ),
            ),
            title: const Text('Log Out'),
            leading: const Icon(FluentIcons.sign_out_24_filled),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}

class NotLoggedInListTiles extends StatelessWidget {
  const NotLoggedInListTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            ),
            title: const Text('Log In'),
            leading: const Icon(FluentIcons.sign_out_24_filled),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreateProfileScreen(),
              ),
            ),
            title: const Text('Create Profile'),
            leading: const Icon(FluentIcons.person_add_24_filled),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
