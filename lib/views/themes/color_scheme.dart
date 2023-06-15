import 'package:flutter/material.dart';
import 'package:sc_app/utils/colors.dart';

ColorScheme lightColorScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: cafeAuLaitBrown,
    onPrimary: cafeAuLaitBrownWhite,
    primaryContainer: cafeAuLaitBrownLight,
    onPrimaryContainer: cafeAuLaitBrownDark,
    secondary: earthYellow,
    onSecondary: earthYellowWhite,
    secondaryContainer: earthYellowLight,
    onSecondaryContainer: earthYellowDark,
    tertiary: palmLeafGreen,
    onTertiary: palmLeafGreenWhite,
    tertiaryContainer: palmLeafGreenLight,
    onTertiaryContainer: palmLeafGreenDark,
    background: white250,
    onBackground: black20,
    surface: white255,
    onSurface: black20,
    surfaceVariant: white245,
    onSurfaceVariant: grey80,
    error: errorRed,
    onError: white245,
    errorContainer: errorRedLight,
    onErrorContainer: black20,
    inverseSurface: grey80,
    onInverseSurface: white245,
    outline: grey120,
    outlineVariant: grey160,
    shadow: grey200,
  );
}

ColorScheme darkColorScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: cafeAuLaitBrown,
    onPrimary: cafeAuLaitBrownBlack,
    primaryContainer: cafeAuLaitBrownDark,
    onPrimaryContainer: cafeAuLaitBrownLight,
    secondary: earthYellow,
    onSecondary: earthYellowBlack,
    secondaryContainer: earthYellowDark,
    onSecondaryContainer: earthYellowLight,
    tertiary: palmLeafGreen,
    onTertiary: palmLeafGreenBlack,
    tertiaryContainer: palmLeafGreenDark,
    onTertiaryContainer: palmLeafGreenLight,
    background: black10,
    onBackground: white245,
    surface: black0,
    onSurface: white245,
    surfaceVariant: black20,
    onSurfaceVariant: grey200,
    error: errorRedLight,
    onError: black20,
    errorContainer: errorRed,
    onErrorContainer: white245,
    inverseSurface: grey200,
    onInverseSurface: black20,
    outline: grey160,
    outlineVariant: grey120,
    shadow: black40,
  );
}

List<String> get subjectColorNames {
  return ['blue', 'turquoise', 'green', 'yellow', 'orange', 'pink', 'purple'];
}

extension CustomColorScheme on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  Color get grey1 => isDarkMode ? grey80 : grey200;

  Color get grey2 => isDarkMode ? grey120 : grey160;

  Color get grey3 => isDarkMode ? grey160 : grey120;

  Color get grey4 => isDarkMode ? grey200 : grey80;

  Color get successColor => isDarkMode ? successGreenLight : successGreen;

  Color get successContainerColor =>
      isDarkMode ? successGreen : successGreenLight;

  Color get warningColor => isDarkMode ? warningYellowLight : warningYellow;

  Color get warningContainerColor =>
      isDarkMode ? warningYellow : warningYellowLight;

  Map<String, Color> get subjectColors {
    return {
      subjectColorNames[0]: isDarkMode ? babyBlueEyesDark : babyBlueEyesLight,
      subjectColorNames[1]: isDarkMode ? freshAirBlueDark : freshAirBlueLight,
      subjectColorNames[2]: isDarkMode ? calamansiDark : calamansiLight,
      subjectColorNames[3]: isDarkMode ? peachDark : peachLight,
      subjectColorNames[4]: isDarkMode ? deepPeachDark : deepPeachLight,
      subjectColorNames[5]:
          isDarkMode ? paleMagentaPinkDark : paleMagentaPinkLight,
      subjectColorNames[6]: isDarkMode ? mauveVioletDark : mauveVioletLight,
    };
  }
}
