import 'package:flutter/material.dart';

class PrimaryTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryTopBar({required this.title, super.key});

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: const <Widget>[
        IconButton(
          onPressed: nothing,
          icon: Icon(Icons.account_circle_outlined),
          tooltip: 'Profile',
        ),
      ],
    );
  }
}

void nothing() {}
