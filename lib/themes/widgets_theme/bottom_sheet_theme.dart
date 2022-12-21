import 'package:flutter/material.dart';

BottomSheetThemeData bottomSheetTheme(Color bgColor) {
  return BottomSheetThemeData(
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
        bottom: Radius.zero,
      ),
    ),
  );
}
