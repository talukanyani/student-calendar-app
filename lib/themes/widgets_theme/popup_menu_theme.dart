import 'package:flutter/material.dart';

PopupMenuThemeData popupMenuTheme({required Color bgColor}) {
  return PopupMenuThemeData(
    elevation: 4,
    color: bgColor,
    shape: ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
