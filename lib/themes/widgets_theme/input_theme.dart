import 'package:flutter/material.dart';

InputDecorationTheme inputTheme({
  required Color borderColor,
  required Color iconColor,
}) {
  return InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.all(8),
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: borderColor,
    ),
    prefixIconColor: iconColor,
  );
}
