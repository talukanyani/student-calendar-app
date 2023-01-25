import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';

class TurnOffAlert extends StatelessWidget {
  const TurnOffAlert({super.key, required this.turnOff});

  final void Function() turnOff;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        title: const Text('Turn Off'),
        content: const Text('Are you sure you want turn off backup?'),
        actionsPadding: const EdgeInsets.only(top: 0, bottom: 8, right: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
            ),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              turnOff();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
            ),
            child: const Text('YES'),
          ),
        ],
      ),
    );
  }
}
