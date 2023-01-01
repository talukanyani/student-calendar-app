import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:sc_app/screens/settings/settings.dart';

class PrimaryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryTopBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      actions: <Widget>[
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsScreen(),
            ),
          ),
          icon: const Icon(FluentIcons.person_circle_24_regular),
          tooltip: 'Profile',
        ),
      ],
    );
  }
}
