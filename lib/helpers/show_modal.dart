import 'package:flutter/material.dart';

showModal(
  BuildContext context, {
  required Widget modal,
  double opacity = 0.25,
}) {
  showDialog(
    barrierColor:
        Theme.of(context).colorScheme.onBackground.withOpacity(opacity),
    context: context,
    builder: (context) => modal,
  );
}
