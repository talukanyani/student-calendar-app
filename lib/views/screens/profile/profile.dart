import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/screens/settings/settings.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/rect_container.dart';

import 'widgets/not_signed_in_list_tiles.dart';
import 'widgets/signed_in_list_tiles.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isSignedIn = user != null;

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
                  isSignedIn ? (user.displayName ?? 'Profile') : 'No Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: context.grey4,
                      ),
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context.grey4,
                      ),
                ),
                const SizedBox(height: 16),
                isSignedIn
                    ? const SignedInListTiles()
                    : const NotSignedInListTiles(),
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
