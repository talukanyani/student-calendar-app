import 'package:flutter/material.dart';
import '../colors.dart';

TextTheme textTheme() {
  return TextTheme(
    headline5: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: CustomColors.fgColor3,
    ),
    bodyText2: TextStyle(
      fontSize: 14,
      color: CustomColors.fgColor4,
    ),
  );
}
