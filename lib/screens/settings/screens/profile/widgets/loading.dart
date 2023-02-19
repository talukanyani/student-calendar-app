import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const Center(child: CircularProgressIndicator()),
    barrierDismissible: false,
    barrierColor: Theme.of(context).backgroundColor.withOpacity(0.75),
  );
}

hideLoading(BuildContext context) => Navigator.pop(context);
