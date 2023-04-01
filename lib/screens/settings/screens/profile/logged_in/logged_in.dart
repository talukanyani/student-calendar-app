import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'change_name.dart';
import 'change_email.dart';
import 'change_password.dart';
import 'delete_profile.dart';
import 'email_verification.dart';

class LoggedInScreen extends StatelessWidget {
  const LoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthenticationController>(context);
    final authProvider = Provider.of<AuthenticationController>(
      context,
      listen: false,
    );

    var email = authController.currentUser?.email ?? '';
    var name = authController.currentUser?.displayName ?? 'Profile';
    var isVerified = authController.currentUser?.emailVerified ?? false;

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
                  color: CustomColorScheme.grey3,
                ),
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  email,
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
          isVerified
              ? const SizedBox()
              : ListTile(
                  onTap: () {
                    authProvider.sendVerificationEmail();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const EmailVerificationScreen();
                      }),
                    );
                  },
                  title: const Text('Verify Email'),
                  subtitle:
                      const Text('Email for this profile is not verified.'),
                  leading: const Icon(Icons.domain_verification),
                ),
          ListTile(
            onTap: () => Show.modal(
              context,
              modal: ConfirmationAlert(
                title: const Text('Log Out?'),
                content: const Text('Are you sure you want to log out?'),
                action: () => authProvider.logout(),
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
