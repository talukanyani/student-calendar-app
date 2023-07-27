import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';

import '../screens/account/account_settings.dart';
import '../screens/account/sign_in.dart';

class Account extends ConsumerWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isSignedIn = user != null;

    return ListTile(
      title: Text(user?.displayName ?? 'Account'),
      subtitle: Text(user?.email ?? 'Account settings'),
      leading: const Icon(
        FluentIcons.person_32_filled,
        size: 32,
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            if (isSignedIn) {
              return const AccountSettingsScreen();
            } else {
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
