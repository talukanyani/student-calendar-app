import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';

class Alert extends StatelessWidget {
  const Alert({
    super.key,
    required this.title,
    required this.titleIcon,
    required this.content,
    required this.actionName,
    required this.action,
  });

  final String title;
  final IconData titleIcon;
  final String content;
  final String actionName;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        title: Wrap(
          children: [
            Icon(titleIcon),
            const SizedBox(width: 16),
            Text(title),
          ],
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
            ),
            child: const Text('Cancel'),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
              action();
            },
            style: OutlinedButton.styleFrom(
              fixedSize: const Size.fromWidth(96),
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Text(actionName),
          ),
        ],
      ),
    );
  }
}

class ConfirmationAlert extends StatelessWidget {
  const ConfirmationAlert({
    super.key,
    required this.title,
    required this.content,
    required this.action,
  });

  final Widget title;
  final Widget content;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        title: title,
        content: content,
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
              Navigator.pop(context);
              action();
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

class InfoAlert extends StatelessWidget {
  const InfoAlert({super.key, required this.title, required this.content});

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        insetPadding: const EdgeInsets.all(16),
        title: Wrap(
          children: [
            const Icon(FluentIcons.info_24_filled),
            const SizedBox(width: 16),
            title,
          ],
        ),
        content: content,
        contentTextStyle: TextStyle(
          fontSize: 15,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
