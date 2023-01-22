import 'package:flutter/material.dart';

showFeedback(BuildContext context, String feedback) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(feedback),
      dismissDirection: DismissDirection.horizontal,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      backgroundColor: Theme.of(context).colorScheme.inverseSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
}
