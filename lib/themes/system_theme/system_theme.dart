import 'package:flutter/services.dart';
import 'package:sc_app/themes/color_scheme.dart';

SystemUiOverlayStyle systemOverlayLightTheme() {
  return SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: white2,
    systemNavigationBarDividerColor: white2,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
