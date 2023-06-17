import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class ConfirmationAlert extends StatelessWidget {
  const ConfirmationAlert({
    super.key,
    required this.title,
    required this.content,
    this.actionName,
    required this.action,
  });

  final Widget title;
  final Widget content;
  final String? actionName;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      insetPadding: const EdgeInsets.all(32),
      elevation: 4,
      title: title,
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: (actionName == null) ? const Text('No') : const Text('Cancel'),
        ),
        OutlinedButton(
          onPressed: () {
            action();
            Navigator.pop(context);
          },
          child: Text(actionName ?? 'Yes'),
        ),
      ],
    );
  }
}

class InfoAlert extends StatelessWidget {
  const InfoAlert({super.key, required this.title, required this.content});

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 4,
      insetPadding: const EdgeInsets.all(16),
      title: title,
      icon: const Icon(FluentIcons.info_24_filled),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
