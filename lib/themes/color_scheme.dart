import 'package:flutter/material.dart';

const white1 = Color(0xFFFAFAFA);
const white2 = Color(0xFFF5F5F5);
const white3 = Color(0xFFF0F0F0);

const black1 = Color(0xFF0A0A0A);
const black2 = Color(0xFF141414);
const black3 = Color(0xFF1E1E1E);

const grey1 = Color(0xFF3C3C3C);
const grey2 = Color(0xFF505050);
const grey3 = Color(0xFF646464);
const grey4 = Color(0xFF787878);
const grey5 = Color(0xFF8C8C8C);
const grey6 = Color(0xFFA0A0A0);

const red1 = Color(0xFFD70014);
const red2 = Color(0xFFAF2828);

const primary = Color(0xFFFFB500);
const primaryLight = Color(0xFFFFE74C);
const primaryDark = Color(0xFFC68600);

const secondary = Color(0xFFC8FF00);
const secondaryLight = Color(0xFFFFFF58);
const secondaryDark = Color(0xFF92CC00);

ColorScheme lightColorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    primaryContainer: primaryDark,
    secondary: secondary,
    secondaryContainer: secondaryDark,
    background: white1,
    surface: white2,
    surfaceVariant: secondaryLight,
    inverseSurface: primaryLight,
    inversePrimary: primaryDark,
    error: red1,
    errorContainer: red2,
    onPrimary: black1,
    onPrimaryContainer: black1,
    onSecondary: black1,
    onSecondaryContainer: black1,
    onBackground: black1,
    onSurface: black1,
    onInverseSurface: black1,
    onError: white1,
    onErrorContainer: white1,
    outline: secondary,
    shadow: white1,
    surfaceTint: white3,
  );
}
