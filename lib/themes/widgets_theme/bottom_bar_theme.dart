import 'package:flutter/material.dart';

BottomNavigationBarThemeData bottomBarTheme(Color bgColor, Color fgColor) {
  return BottomNavigationBarThemeData(
    backgroundColor: bgColor,
    elevation: 0,
    selectedItemColor: fgColor,
    unselectedItemColor: fgColor,
    selectedLabelStyle: const TextStyle(fontSize: 12),
  );
}
