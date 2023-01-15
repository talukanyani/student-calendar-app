import 'package:flutter/material.dart';

TextTheme textTheme(Color textColor1, Color hColor1) {
  return TextTheme(
    headline5: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: hColor1,
    ),
    headline6: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: hColor1,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: textColor1,
    ),
  );
}
