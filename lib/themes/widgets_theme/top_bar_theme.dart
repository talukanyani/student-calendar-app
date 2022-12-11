import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sc_app/themes/colors.dart';

AppBarTheme topBarTheme() {
  return AppBarTheme(
    backgroundColor: CustomColors.bgColor2,
    foregroundColor: CustomColors.fgColor3,
    iconTheme: IconThemeData(
      size: 28,
      color: CustomColors.fgColor3,
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: CustomColors.bgColor2,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
