import 'package:flutter/material.dart';

TextTheme textTheme(Color textColor1, Color hColor1) {
  return TextTheme(
    headline4: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: textColor1,
    ),
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
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: textColor1,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: textColor1,
    ),
  );
}
