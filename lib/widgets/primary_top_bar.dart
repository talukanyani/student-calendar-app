import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class PrimaryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryTopBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(FluentIcons.person_circle_24_regular),
          tooltip: 'Profile',
        ),
      ],
    );
  }
}
