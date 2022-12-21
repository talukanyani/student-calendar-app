import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBarTheme topBarTheme(Color bgColor, Color fgColor) {
  return AppBarTheme(
    backgroundColor: bgColor,
    foregroundColor: fgColor,
    iconTheme: IconThemeData(
      size: 28,
      color: fgColor,
    ),
    elevation: 0,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}
