import 'package:flutter/material.dart';

const white245 = Color(0xFFF5F5F5);
const white235 = Color(0xFFEBEBEB);
const white225 = Color(0xFFE1E1E1);

const black20 = Color(0xFF141414);
const black40 = Color(0xFF282828);
const black60 = Color(0xFF3C3C3C);

const grey80 = Color(0xFF505050);
const grey120 = Color(0xFF787878);
const grey160 = Color(0xFFA0A0A0);

const errorRed = Color(0xFFBF4040);
const errorRedLight = Color(0xFFF6C1C1);

const successGreen = Color(0xFF40BF40);
const successGreenLight = Color(0xFFC1F6C1);

const warningYellow = Color(0xFFBFBF40);
const warningYellowLight = Color(0xFFF6F6C1);

const brown = Color(0xFFA5785E);
const brownDark = Color(0xFF866255);
const brownLight = Color(0xFFDBCBBB);
const brownWhite1 = Color(0xFFEAE5D9);
const brownWhite2 = Color(0xFFE5E0D4);
const brownWhite3 = Color(0xFFE0DBCF);

const orange = Color(0xFFDEAF5F);
const orangeDark = Color(0xFFCA7923);
const orangeLight = Color(0xFFF0DCB7);
const orangeWhite = Color(0xFFF9F1E2);

const green = Color(0xFF7AA433);
const greenDark = Color(0xFF264F0A);
const greenLight = Color(0xFFBCCF9A);
const greenWhite = Color(0xFFEFF4E6);

ColorScheme lightColorScheme() {
  return const ColorScheme(
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
  );
}
