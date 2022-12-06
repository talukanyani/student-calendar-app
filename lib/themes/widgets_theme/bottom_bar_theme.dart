import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

BottomNavigationBarThemeData bottomBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: brownWhite3,
    elevation: 0,
    selectedItemColor: black40,
    unselectedItemColor: black60,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 30,
          color: brown,
          offset: Offset(5, 3),
        ),
      ],
    ),
    selectedIconTheme: IconThemeData(
      shadows: <Shadow>[
        Shadow(
          blurRadius: 30,
          color: brown,
          offset: Offset(5, 3),
        ),
      ],
    ),
  );
}
