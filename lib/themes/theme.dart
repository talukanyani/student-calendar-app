import 'package:flutter/material.dart';

import '../utils/colors.dart';
import 'color_scheme.dart';

import './widgets_theme/top_bar_theme.dart';
import './widgets_theme/bottom_bar_theme.dart';
import './widgets_theme/text_theme.dart';
import './widgets_theme/bottom_sheet_theme.dart';
import './widgets_theme/input_theme.dart';
import './widgets_theme/popup_menu_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: colorScheme(),
    primaryColor: brown,
    primaryColorLight: brownLight,
    primaryColorDark: brownDark,
    backgroundColor: white245,
    scaffoldBackgroundColor: white245,
    errorColor: errorRed,
    disabledColor: grey160,
    shadowColor: grey200,
    hintColor: grey160,
    dividerColor: grey160,
    focusColor: brownLight,
    indicatorColor: brownDark,
    toggleableActiveColor: green,
    textTheme: textTheme(onBackground: black20),
    appBarTheme: topBarTheme(white240, grey80),
    bottomNavigationBarTheme: bottomBarTheme(white235, grey80),
    bottomSheetTheme: bottomSheetTheme(white235),
    inputDecorationTheme: inputTheme(
      borderColor: grey120,
      hintColor: grey160,
    ),
    popupMenuTheme: popupMenuTheme(bgColor: white255),
  );
}
