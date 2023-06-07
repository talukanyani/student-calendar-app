import 'package:flutter/material.dart';

BottomNavigationBarThemeData bottomNavBarTheme({
  required Color bgColor,
  required Color fgColor,
}) {
  return BottomNavigationBarThemeData(
    backgroundColor: bgColor,
    elevation: 0,
    selectedItemColor: fgColor,
    unselectedItemColor: fgColor,
    selectedLabelStyle: const TextStyle(fontSize: 12),
  );
}
