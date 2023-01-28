import 'package:flutter/material.dart';

TextTheme textTheme({required Color onBackground}) {
  return TextTheme(
    headline3: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      color: onBackground,
    ),
    headline4: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: onBackground,
    ),
    headline5: const TextStyle(fontSize: 20),
    headline6: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: const TextStyle(fontSize: 14),
  );
}
