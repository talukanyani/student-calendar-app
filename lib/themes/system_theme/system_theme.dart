import 'package:flutter/services.dart';
import 'package:sc_app/themes/colors.dart';

SystemUiOverlayStyle androidSystemOverlay() {
  return SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: CustomColors.bgColor3,
    systemNavigationBarDividerColor: CustomColors.bgColor3,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
