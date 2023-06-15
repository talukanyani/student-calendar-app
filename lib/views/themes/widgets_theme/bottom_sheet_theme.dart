import 'package:flutter/material.dart';

BottomSheetThemeData bottomSheetTheme({required Color bgColor}) {
  return BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
        bottom: Radius.zero,
      ),
    ),
  );
}
