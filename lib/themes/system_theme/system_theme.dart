import 'dart:js';

import 'package:flutter/services.dart';
import 'package:sc_app/themes/color_scheme.dart';

SystemUiOverlayStyle systemOverlayLightTheme() {
  return SystemUiOverlayStyle.light.copyWith(
    statusBarColor: white2,
    systemNavigationBarColor: white2,
    systemNavigationBarDividerColor: white2,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
