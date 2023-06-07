import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'color_scheme.dart';
import './widgets_theme/app_bar_theme.dart';
import './widgets_theme/bottom_nav_bar_theme.dart';
import './widgets_theme/bottom_sheet_theme.dart';
import './widgets_theme/input_theme.dart';
import './widgets_theme/popup_menu_theme.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    colorScheme: lightColorScheme(),
    primaryColor: cafeAuLaitBrown,
    primaryColorLight: cafeAuLaitBrownLight,
    primaryColorDark: cafeAuLaitBrownDark,
    scaffoldBackgroundColor: white250,
    disabledColor: grey160,
    shadowColor: grey200,
    hintColor: grey160,
    dividerColor: grey160,
    hoverColor: white245,
    highlightColor: grey200,
    focusColor: cafeAuLaitBrownLight,
    indicatorColor: cafeAuLaitBrownDark,
    dialogBackgroundColor: white255,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()},
    ),
    appBarTheme: appBarTheme(
      bgColor: white250,
      fgColor: grey80,
      iconsBrightness: Brightness.dark,
    ),
    bottomNavigationBarTheme: bottomNavBarTheme(
      bgColor: white245,
      fgColor: grey80,
    ),
    bottomSheetTheme: bottomSheetTheme(bgColor: white245),
    inputDecorationTheme: inputTheme(
      borderColor: grey120,
      hintColor: grey160,
    ),
    popupMenuTheme: popupMenuTheme(bgColor: white255),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: darkColorScheme(),
    primaryColor: cafeAuLaitBrown,
    primaryColorLight: cafeAuLaitBrownLight,
    primaryColorDark: cafeAuLaitBrownDark,
    scaffoldBackgroundColor: black10,
    disabledColor: grey120,
    shadowColor: black20,
    hintColor: grey120,
    dividerColor: grey120,
    hoverColor: black20,
    highlightColor: grey80,
    focusColor: cafeAuLaitBrownDark,
    indicatorColor: cafeAuLaitBrownLight,
    dialogBackgroundColor: black0,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()},
    ),
    appBarTheme: appBarTheme(
      bgColor: black10,
      fgColor: grey200,
      iconsBrightness: Brightness.light,
    ),
    bottomNavigationBarTheme: bottomNavBarTheme(
      bgColor: black20,
      fgColor: grey200,
    ),
    bottomSheetTheme: bottomSheetTheme(bgColor: black20),
    inputDecorationTheme: inputTheme(
      borderColor: grey160,
      hintColor: grey120,
    ),
    popupMenuTheme: popupMenuTheme(bgColor: black0),
  );
}
