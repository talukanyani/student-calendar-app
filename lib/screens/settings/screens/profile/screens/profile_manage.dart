import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/rect_container.dart';
import '../widgets/loading.dart';
import 'edit_name.dart';
import 'change_email.dart';
import 'change_password.dart';
import 'delete_profile.dart';
import 'email_verification.dart';

class ProfileManageScreen extends StatefulWidget {
  const ProfileManageScreen({super.key});

  @override
  State<ProfileManageScreen> createState() => _ProfileManageScreenState();
}

class _ProfileManageScreenState extends State<ProfileManageScreen> {
  String? errorMessage;

  void logout(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    showLoading(context);

    authProvider.logout().then((value) {
      hideLoading(context);

      if (value == AuthStatus.unknownError) {
        setState(() {
          errorMessage = 'There was an error while logging you out.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    final user = authProvider.currentUser;
    String email = user?.email ?? '';
    String name = user?.displayName ?? 'Profile';
    bool isVerified = user?.emailVerified ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        primary: false,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  FluentIcons.person_circle_32_filled,
                  size: 64,
                  color: CustomColorScheme.grey3,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: CustomColorScheme.grey4,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: OutlinedButton(
              onPressed: () {
                showModal(
                  context,
                  modal: ConfirmationAlert(
                    title: const Text('Log Out?'),
                    content: const Text('Are you sure you want to log out?'),
                    action: () => logout(context),
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: CustomColorScheme.background5,
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                fixedSize: const Size(128, 32),
              ),
              child: const Text('Log Out'),
            ),
          ),
          SizedBox(height: errorMessage == null ? 0 : 4),
          Text(
            errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          const SizedBox(height: 12),
          isVerified
              ? const SizedBox(height: 0)
              : RectContainer(
                  child: ListTile(
                    horizontalTitleGap: 0,
                    title: const Text('Your profile is not complete!'),
                    subtitle:
                        const Text('Email for this profile is not verified.'),
                    trailing: TextButton(
                      onPressed: () {
                        authProvider.sendVerificationEmail();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const EmailVerificationScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('Verify Email'),
                    ),
                  ),
                ),
          SizedBox(height: isVerified ? 0 : 16),
          RectContainer(
            child: Column(
              children: [
                const SizedBox(height: 8),
                Text(
                  'Manage Profile',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 16),
                const Divider(height: 0),
                const Tile(title: 'Edit Name', page: EditName()),
                const Divider(height: 0),
                Tile(
                  title: 'Change Email',
                  page: ChangeEmail(email: email),
                ),
                const Divider(height: 0),
                Tile(
                  title: 'Change Password',
                  page: ChangePassword(email: email),
                ),
                const Divider(height: 0),
                Tile(
                  title: 'Delete Profile',
                  page: DeleteProfile(email: email),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.title, required this.page});

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        title: Text(title),
        trailing: const Icon(FluentIcons.ios_arrow_rtl_24_filled),
        visualDensity: const VisualDensity(vertical: -1),
      ),
    );
  }
}
