import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/themes/widgets_theme/top_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_bar_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme(),
    primaryColor: brown,
    primaryColorLight: brownLight,
    primaryColorDark: brownDark,
    backgroundColor: brownWhite1,
    scaffoldBackgroundColor: brownWhite1,
    hoverColor: brownLight,
    highlightColor: brown,
    indicatorColor: brownDark,
    shadowColor: brownLight,
    splashColor: brown,
    toggleableActiveColor: green,
    disabledColor: grey120,
    hintColor: black60,
    errorColor: errorRed,
    focusColor: orangeWhite,
    //
    appBarTheme: topBarTheme(),
    bottomNavigationBarTheme: bottomBarTheme(),
  );
}
