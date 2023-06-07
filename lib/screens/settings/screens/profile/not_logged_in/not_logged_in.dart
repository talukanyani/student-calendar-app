import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'create_profile.dart';
import 'login.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  FluentIcons.person_circle_32_regular,
                  size: 64,
                  color: context.grey3,
                ),
                Text(
                  'No Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            title: const Text('Log In'),
            leading: const Icon(Icons.login),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateProfileScreen(),
                ),
              );
            },
            title: const Text('Create Profile'),
            leading: const Icon(Icons.person_add_outlined),
          ),
        ],
      ),
    );
  }
}
