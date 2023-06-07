import 'package:flutter/material.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/snackbar.dart';

class Show {
  static modal(
    BuildContext context, {
    required Widget modal,
    double opacity = 0.2,
  }) {
    showDialog(
      context: context,
      barrierColor:
          Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
      builder: (context) => modal,
    );
  }

  static snackBar(
    BuildContext context, {
    required String text,
    SnackBarIcon? snackBarIcon,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      mySnackBar(
        context,
        text: text,
        snackBarIcon: snackBarIcon ?? SnackBarIcon.none,
        action: action,
      ),
    );
  }
}

class Hide {
  static modal(BuildContext context) => Navigator.pop(context);

  static snackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
