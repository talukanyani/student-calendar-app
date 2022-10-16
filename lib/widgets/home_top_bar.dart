import 'package:flutter/material.dart';

class HomeTopBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('SC'),
      actions: const <Widget>[
        IconButton(
          onPressed: nothing,
          icon: Icon(Icons.settings),
        ),
      ],
    );
  }
}

void nothing() {}
