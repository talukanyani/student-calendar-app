import 'package:flutter/material.dart';

Widget popupMenuTile({required String title, required IconData icon}) {
  return ListTile(
    title: Text(title),
    leading: Icon(icon, size: 20),
    visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
