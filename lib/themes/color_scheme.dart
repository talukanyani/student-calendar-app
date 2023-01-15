import 'package:flutter/material.dart';
import '../utils/colors.dart';

ColorScheme colorScheme() {
  return const ColorScheme(
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
    onBackground: black20,
    surface: white250,
    onSurface: black20,
    surfaceVariant: white235,
    onSurfaceVariant: grey80,
    error: errorRed,
    onError: white245,
    errorContainer: errorRedLight,
    onErrorContainer: black20,
    inverseSurface: grey80,
    onInverseSurface: white245,
    outline: grey200,
    shadow: grey200,
  );
}

class CustomColorScheme {
  static Color background1 = white255;
  static Color background2 = white250;
  static Color background3 = white245;
  static Color background4 = white240;
  static Color background5 = white235;

  static Color foreground1 = black0;
  static Color foreground2 = black10;
  static Color foreground3 = black20;
  static Color foreground4 = black30;
  static Color foreground5 = black40;

  static Color grey1 = grey200;
  static Color grey2 = grey160;
  static Color grey3 = grey120;
  static Color grey4 = grey80;

  static Color success1 = successGreen;
  static Color success2 = successGreenLight;
  static Color warning1 = warningYellow;
  static Color warning2 = warningYellowLight;

  static Color babyBlueEyes = babyBlueEyesLight;
  static Color freshAirBlue = freshAirBlueLight;
  static Color calamnsi = calamnsiLight;
  static Color peach = peachLight;
  static Color deepPeach = deepPeachLight;
  static Color paleMagentaPink = paleMagentaPinkLight;
  static Color mauveViolet = mauveVioletLight;
}
