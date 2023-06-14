import 'package:flutter/material.dart';

Widget popupMenuTile({required String title, required IconData icon}) {
  return ListTile(
    title: Text(title),
    leading: Icon(icon, size: 16),
    visualDensity: const VisualDensity(vertical: -3),
    minLeadingWidth: 0,
    horizontalTitleGap: 16,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
  );
}
