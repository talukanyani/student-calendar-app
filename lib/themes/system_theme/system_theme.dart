import 'package:flutter/services.dart';
import 'package:sc_app/themes/colors.dart';

SystemUiOverlayStyle androidSystemOverlay() {
  return SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: CustomColors.bgColor1,
    systemNavigationBarDividerColor: CustomColors.bgColor1,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
