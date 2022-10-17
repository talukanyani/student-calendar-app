import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/themes/widgets_theme/top_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_bar_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme(),
    primaryColor: primary,
    primaryColorLight: primaryLight,
    primaryColorDark: primaryDark,
    backgroundColor: white1,
    scaffoldBackgroundColor: white1,
    hoverColor: primaryLight,
    highlightColor: primary,
    indicatorColor: primaryDark,
    shadowColor: white1,
    splashColor: primary,
    toggleableActiveColor: secondary,
    disabledColor: grey4,
    hintColor: grey1,
    errorColor: red1,
    focusColor: secondaryLight,
    //
    appBarTheme: topBarTheme(),
    bottomNavigationBarTheme: bottomBarTheme(),
  );
}
