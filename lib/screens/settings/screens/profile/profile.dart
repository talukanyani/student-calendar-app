import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'widgets/login_body.dart';
import 'widgets/loading.dart';
import 'screens/edit_name.dart';
import 'screens/change_email.dart';
import 'screens/change_password.dart';
import 'screens/delete_profile.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationController>(context).currentUser;
    bool isLoggedIn = user != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: isLoggedIn ? const ProfileManageBody() : const ProfileLoginBody(),
    );
  }
}

class ProfileManageBody extends StatefulWidget {
  const ProfileManageBody({super.key});

  @override
  State<ProfileManageBody> createState() => _ProfileManageBodyState();
}

class _ProfileManageBodyState extends State<ProfileManageBody> {
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
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);
    final email = authProvider.currentUser!.email ?? '';
    const name = 'Talukanyani';

    return ListView(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
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
            SizedBox(height: errorMessage == null ? 0 : 4),
            Text(
              errorMessage ?? '',
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
