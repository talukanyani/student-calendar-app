import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sc_app/themes/color_scheme.dart';

AppBarTheme topBarTheme() {
  return const AppBarTheme(
    backgroundColor: white2,
    foregroundColor: black1,
    iconTheme: IconThemeData(size: 28),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: white2,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
