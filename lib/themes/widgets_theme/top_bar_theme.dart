import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sc_app/themes/color_scheme.dart';

AppBarTheme topBarTheme() {
  return const AppBarTheme(
    backgroundColor: brownWhite2,
    foregroundColor: black40,
    iconTheme: IconThemeData(size: 28),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: brownWhite2,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
