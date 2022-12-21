import 'package:flutter/material.dart';

import 'package:sc_app/themes/colors.dart';

import 'package:sc_app/themes/widgets_theme/top_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_bar_theme.dart';
import 'package:sc_app/themes/widgets_theme/text_theme.dart';
import 'package:sc_app/themes/widgets_theme/bottom_sheet_theme.dart';

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
      background: white245,
      onBackground: black40,
      surface: white250,
      onSurface: black30,
      surfaceVariant: white255,
      onSurfaceVariant: black20,
      error: errorRed,
      onError: white255,
      errorContainer: errorRedLight,
      onErrorContainer: black0,
      outline: brown,
      inverseSurface: grey160,
      onInverseSurface: black10,
      inversePrimary: grey120,
      shadow: grey200,
      surfaceTint: grey80,
    ),
    primaryColor: brown,
    primaryColorLight: brownLight,
    primaryColorDark: brownDark,
    backgroundColor: white245,
    scaffoldBackgroundColor: white245,
    errorColor: errorRed,
    disabledColor: grey160,
    shadowColor: grey200,
    hintColor: grey120,
    dividerColor: grey160,
    focusColor: brownLight,
    indicatorColor: brownDark,
    toggleableActiveColor: green,
    textTheme: textTheme(black40, grey80),
    appBarTheme: topBarTheme(white240, grey80),
    bottomNavigationBarTheme: bottomBarTheme(white235, grey80),
    bottomSheetTheme: bottomSheetTheme(white235),
  );
}
