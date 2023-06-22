import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/widgets/buttons.dart';

import '../modals/edit_name.dart';
import 'delete_profile.dart';

class ManageProfileScreen extends ConsumerWidget {
  const ManageProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Profile')),
      body: ListView(
        primary: false,
        children: [
          ListTile(
            title: Text(ref.watch(userProvider)?.displayName ?? ''),
            subtitle: const Text('Name'),
            trailing: SizedBox(
              height: 32,
              child: ForegroundFilledBtn(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const EditNameModal(),
                ),
                child: const Text('Edit Name'),
              ),
            ),
          ),
          ListTile(
            title: Text(ref.watch(userProvider)?.email ?? ''),
            subtitle: const Text('Email'),
          ),
          ListTile(
            title: const Text('Profile'),
            trailing: SizedBox(
              height: 28,
              child: ForegroundFilledBtn(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DeleteProfileScreen(),
                  ),
                ),
                child: const Text('Delete'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
