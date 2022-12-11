import 'package:flutter/material.dart';

import 'package:sc_app/themes/colors.dart';

BottomNavigationBarThemeData bottomBarTheme() {
  return BottomNavigationBarThemeData(
    backgroundColor: CustomColors.bgColor3,
    elevation: 0,
    selectedItemColor: CustomColors.fgColor3,
    unselectedItemColor: CustomColors.fgColor3,
    selectedLabelStyle: const TextStyle(fontSize: 12),
  );
}
