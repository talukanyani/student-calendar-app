import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import 'package:sc_app/views/widgets/rect_container.dart';

import 'modals/edit_name.dart';
import 'screens/delete_account.dart';

class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availWidth = MediaQuery.of(context).size.width;
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Account Settings')),
      body: SingleChildScrollView(
        primary: false,
        padding: (availWidth < 480)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: ((availWidth - 480) / 2)),
        child: RectContainer(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Icon(
                FluentIcons.person_circle_32_filled,
                size: 64,
                color: context.grey3,
              ),
              const SizedBox(height: 16),
              Text(
                user?.displayName ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                user?.email ?? '',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              Material(
                type: MaterialType.transparency,
                child: ListTile(
                  title: const Text('Sign Out'),
                  leading: const Icon(Icons.logout_outlined),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => ConfirmationAlert(
                      title: const Text('Sign Out?'),
                      content: const Text('Are you sure you want to sign out?'),
                      action: () {
                        ref.read(authProvider.notifier).signOut();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: ListTile(
                  title: const Text('Edit Name'),
                  leading: const Icon(Icons.edit_outlined),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => const EditNameModal(),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: ListTile(
                  title: const Text('Delete Account'),
                  leading: const Icon(Icons.delete_outline),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DeleteProfileScreen(),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
