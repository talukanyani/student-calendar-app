import 'package:flutter/services.dart';
import 'package:sc_app/themes/color_scheme.dart';

SystemUiOverlayStyle androidSystemOverlay() {
  return SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: brownWhite3,
    systemNavigationBarDividerColor: brownWhite3,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
