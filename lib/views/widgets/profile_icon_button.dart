import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/views/screens/profile/profile.dart';

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      ),
      icon: const Icon(FluentIcons.person_circle_24_regular),
      tooltip: 'Profile',
    );
  }
}
