import 'package:flutter/material.dart';

ListTileThemeData listTileTheme() {
  return const ListTileThemeData(
    minLeadingWidth: 0,
    horizontalTitleGap: 16,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 0,
    ),
  );
}
