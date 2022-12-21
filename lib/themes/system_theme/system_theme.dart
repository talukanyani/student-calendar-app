import 'package:flutter/services.dart';
import 'package:sc_app/themes/colors.dart';

SystemUiOverlayStyle androidSystemOverlay() {
  return SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: white235,
    systemNavigationBarDividerColor: white235,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
