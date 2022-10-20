import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

BottomNavigationBarThemeData bottomBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: white2,
    elevation: 0,
    selectedItemColor: grey1,
    unselectedItemColor: grey1,
    selectedLabelStyle: TextStyle(
      fontSize: 12,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 30,
          color: primary,
          offset: Offset(5, 0),
        ),
      ],
    ),
    selectedIconTheme: IconThemeData(
      shadows: <Shadow>[
        Shadow(
          blurRadius: 30,
          color: primary,
          offset: Offset(5, 3),
        ),
      ],
    ),
  );
}
