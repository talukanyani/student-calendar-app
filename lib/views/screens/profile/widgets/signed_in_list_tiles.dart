import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/widgets/alerts.dart';

import '../screens/manage_profile.dart';

class SignedInListTiles extends ConsumerWidget {
  const SignedInListTiles({super.key});

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
                title: const Text('Sign Out?'),
                content: const Text('Are you sure you want to sign out?'),
                action: () {
                  ref.read(authProvider.notifier).signOut();
                },
              ),
            ),
            title: const Text('Sign Out'),
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
