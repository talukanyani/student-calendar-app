import 'package:flutter/material.dart';
import 'screens/change_name.dart';
import 'screens/change_email.dart';
import 'screens/change_password.dart';
import 'screens/delete_profile.dart';

class ManageProfileScreen extends StatelessWidget {
  const ManageProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Profile')),
      body: ListView(
        primary: false,
        children: [
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
        ],
      ),
    );
  }
}
