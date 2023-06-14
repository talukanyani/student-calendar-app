import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'buttons.dart';

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
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 4,
      title: title,
      content: content,
      actions: [
        PrimaryBorderBtn(
          onPressed: () => Navigator.pop(context),
          child: const Text('No'),
        ),
        PrimaryBorderBtn(
          onPressed: () {
            action();
            Navigator.pop(context);
          },
          child: const Text('Yes'),
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
      title: Row(
        children: [
          const Icon(FluentIcons.info_24_filled),
          const SizedBox(width: 16),
          Expanded(child: title),
        ],
      ),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onBackground,
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
