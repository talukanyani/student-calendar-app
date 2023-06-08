import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/screens/settings/settings.dart';

class PrimaryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryTopBar({required this.title, this.backgroundColor, super.key});

  final String title;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          ),
          icon: const Icon(FluentIcons.person_circle_24_regular),
          tooltip: 'Profile',
        ),
      ],
    );
  }
}
