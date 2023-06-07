import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'change_name.dart';
import 'change_email.dart';
import 'change_password.dart';
import 'delete_profile.dart';

class LoggedInScreen extends ConsumerWidget {
  const LoggedInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        primary: false,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Icon(
                  FluentIcons.person_circle_32_filled,
                  size: 64,
                  color: context.grey3,
                ),
                Text(
                  ref.watch(userNameProvider) ?? 'Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  ref.watch(userEmailProvider) ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Edit name'),
            leading: const Icon(Icons.edit),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChangeNameScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('Change Email'),
            leading: const Icon(Icons.email),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChangeEmailScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('Change Password'),
            leading: const Icon(Icons.password),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            ),
          ),
          ListTile(
            title: const Text('Delete Profile'),
            leading: const Icon(Icons.delete),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DeleteProfileScreen(),
              ),
            ),
          ),
          ListTile(
            onTap: () => Show.modal(
              context,
              modal: ConfirmationAlert(
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
      ),
    );
  }
}
