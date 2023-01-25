import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/rect_container.dart';

import 'widgets/login_body.dart';

import 'screens/edit_name.dart';
import 'screens/change_email.dart';
import 'screens/change_password.dart';
import 'screens/delete_profile.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  static bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: isLoggedIn ? const ProfileBody() : const LoginBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  static const name = 'Talukanyani';
  static const email = 'tmutshaeni@hotmail.com';

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.1),
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                fixedSize: const Size.fromWidth(128),
              ),
              child: const Text('Log Out'),
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
              const Tile(
                title: 'Change Email',
                page: ChangeEmail(email: email),
              ),
              const Divider(height: 0),
              const Tile(
                title: 'Change Password',
                page: ChangePassword(email: email),
              ),
              const Divider(height: 0),
              const Tile(
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
