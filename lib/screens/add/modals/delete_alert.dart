import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';
import '../widgets/snackbar.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({
    super.key,
    required this.contentName,
    required this.deleteContent,
  });

  final String contentName;
  final void Function() deleteContent;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        title: const Text('Delete Permanently'),
        content: Text(
          '$contentName will be deleted permanently.',
        ),
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
              deleteContent();
              Navigator.pop(context);
              showFeedback(context, '$contentName was permanently deleted.');
            },
            style: OutlinedButton.styleFrom(
              fixedSize: const Size.fromWidth(96),
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              side: BorderSide(
                width: 2,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
