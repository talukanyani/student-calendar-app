import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/screens/settings/settings.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import 'screens/manage_profile/manage_profile.dart';
import 'screens/create_profile.dart';
import 'screens/login.dart';

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
          Padding(
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
              ],
            ),
          ),
          isLoggedIn ? const LoggedInListTiles() : const NotLoggedInListTiles(),
          ListTile(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            title: const Text('App Settings'),
            subtitle: const Text('Theme, Sync, and more'),
            leading: const Column(
              children: [
                Spacer(),
                Icon(Icons.settings, size: 32),
                Spacer(),
              ],
            ),
          )
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
        ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ManageProfileScreen(),
            ),
          ),
          title: const Text('Manage Profile'),
          leading: const Icon(Icons.manage_accounts_outlined),
        ),
        ListTile(
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
          leading: const Icon(Icons.logout),
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
        ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          ),
          title: const Text('Log In'),
          leading: const Icon(Icons.login),
        ),
        ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateProfileScreen(),
            ),
          ),
          title: const Text('Create Profile'),
          leading: const Icon(Icons.person_add_outlined),
        ),
      ],
    );
  }
}
