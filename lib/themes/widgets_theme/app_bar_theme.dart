import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBarTheme appBarTheme({
  required Color bgColor,
  required Color fgColor,
  required Brightness iconsBrightness,
}) {
  return AppBarTheme(
    backgroundColor: bgColor,
    foregroundColor: fgColor,
    iconTheme: IconThemeData(
      size: 28,
      color: fgColor,
    ),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: iconsBrightness,
    ),
  );
}
