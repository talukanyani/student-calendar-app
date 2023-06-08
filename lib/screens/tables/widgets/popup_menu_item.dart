import 'package:flutter/material.dart';

PopupMenuItem popupMenuItem({
  required String itemName,
  required IconData itemIcon,
  required void Function() onTap,
}) {
  return PopupMenuItem(
    padding: const EdgeInsets.all(0),
    child: ListTile(
      onTap: onTap,
      title: Text(itemName),
      leading: Icon(itemIcon, size: 20),
      visualDensity: const VisualDensity(vertical: -3),
      minLeadingWidth: 0,
      horizontalTitleGap: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    ),
  );
}
