import 'package:flutter/material.dart';

import 'package:sc_app/themes/colors.dart';

import 'package:sc_app/themes/widgets_theme/top_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_bar_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: brown,
      onPrimary: brownWhite1,
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
      background: brownWhite1,
      onBackground: black20,
      surface: brownWhite2,
      onSurface: black20,
      surfaceVariant: brownLight,
      onSurfaceVariant: brownDark,
      error: errorRed,
      onError: white245,
      errorContainer: errorRedLight,
      onErrorContainer: black20,
      outline: brown,
      inverseSurface: orangeLight,
      onInverseSurface: orangeDark,
      inversePrimary: orange,
      shadow: brownLight,
      surfaceTint: brownLight,
    ),
    primaryColor: brown,
    primaryColorLight: brownLight,
    primaryColorDark: brownDark,
    backgroundColor: brownWhite1,
    scaffoldBackgroundColor: brownWhite1,
    indicatorColor: brownDark,
    shadowColor: brownLight,
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
