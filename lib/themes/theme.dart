import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const white1 = Color(0xFFFAFAFA);
const white2 = Color(0xFFF5F5F5);
const white3 = Color(0xFFF0F0F0);

const black1 = Color(0xFF0A0A0A);
const black2 = Color(0xFF141414);
const black3 = Color(0xFF1E1E1E);

const red1 = Color(0xFFD70000);
const red2 = Color(0xFFFF2828);
const red3 = Color(0xFF870000);

const primary = Color(0xFF2A344D);

const primaryLighten1 = Color(0xFF525C75);
const primaryLighten2 = Color(0xFF7A849D);
const primaryLighten3 = Color(0xFFA2ACC5);
const primaryLighten4 = Color(0xFFCAD4ED);
const primaryLighten5 = Color(0xFFF2FCFF);

const primaryDarken1 = Color(0xFF162039);
const primaryDarken2 = Color(0xFF020C25);
const primaryDarken3 = Color(0xFF000011);

const secondary = Color(0xFF1F8327);

const secondaryLighten1 = Color(0xFF47AB4F);
const secondaryLighten2 = Color(0xFF6FD377);
const secondaryLighten3 = Color(0xFF97FB9F);
const secondaryLighten4 = Color(0xFFBFFFC7);

const secondaryDarken1 = Color(0xFF156F1D);
const secondaryDarken2 = Color(0xFF0B5113);
const secondaryDarken3 = Color(0xFF013309);
const secondaryDarken4 = Color(0xFF001F00);

ThemeData appTheme() {
  return ThemeData(
    brightness: Brightness.light,
    //
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      background: white1,
      surface: primaryLighten3,
      error: red1,
      onPrimary: white1,
      onSecondary: white1,
      onBackground: black1,
      onSurface: black1,
      onError: black1,
      outline: primaryLighten1,
      shadow: primaryLighten4,
    ),

    primaryColor: primary,

    backgroundColor: white1,

    scaffoldBackgroundColor: white1,

    splashColor: primary,

    toggleableActiveColor: secondary,

    hintColor: black2,

    highlightColor: primaryLighten1,

    indicatorColor: primaryLighten2,

    appBarTheme: topBarTheme(),
  );
}

AppBarTheme topBarTheme() {
  return const AppBarTheme(
    backgroundColor: white2,
    foregroundColor: primaryDarken3,
    iconTheme: IconThemeData(size: 28),
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: white2,
    ),
  );
}
