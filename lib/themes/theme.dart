import 'package:flutter/material.dart';

import 'package:sc_app/themes/colors.dart';

import 'package:sc_app/themes/widgets_theme/top_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/text_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: brown,
      onPrimary: brownWhite,
      primaryContainer: brownLight,
      onPrimaryContainer: brownDark,
      secondary: orange,
      onSecondary: orangeWhite,
      secondaryContainer: orangeLight,
      onSecondaryContainer: orangeDark,
      tertiary: green,
      onTertiary: greenWhite,
      tertiaryContainer: greenLight,
      onTertiaryContainer: greenDark,
      background: white240,
      onBackground: black20,
      surface: white245,
      onSurface: black20,
      surfaceVariant: brownLight,
      onSurfaceVariant: brownDark,
      error: errorRed,
      onError: white250,
      errorContainer: errorRedLight,
      onErrorContainer: black20,
      outline: brown,
      inverseSurface: orangeLight,
      onInverseSurface: orangeDark,
      inversePrimary: orange,
      shadow: grey200,
      surfaceTint: brownLight,
    ),
    primaryColor: brown,
    primaryColorLight: brownLight,
    primaryColorDark: brownDark,
    backgroundColor: white240,
    scaffoldBackgroundColor: white240,
    indicatorColor: brownDark,
    shadowColor: grey200,
    toggleableActiveColor: green,
    disabledColor: grey120,
    hintColor: black50,
    errorColor: errorRed,
    focusColor: orangeWhite,
    textTheme: textTheme(),
    appBarTheme: topBarTheme(),
    bottomNavigationBarTheme: bottomBarTheme(),
  );
}
