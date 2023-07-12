import 'package:flutter/material.dart';

InputDecorationTheme inputTheme({
  required Color borderColor,
  required Color hintColor,
}) {
  OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      width: 2,
      color: borderColor,
    ),
    borderRadius: BorderRadius.circular(16),
  );

  return InputDecorationTheme(
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: hintColor,
    ),
    prefixIconColor: borderColor,
    suffixIconColor: borderColor,
  );
}
