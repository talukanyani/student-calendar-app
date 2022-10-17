import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

BottomNavigationBarThemeData bottomBarTheme() {
  return const BottomNavigationBarThemeData(
    backgroundColor: white2,
    elevation: 0,
    unselectedItemColor: grey3,
    selectedLabelStyle: TextStyle(fontSize: 12),
    selectedIconTheme: IconThemeData(
      shadows: <Shadow>[
        Shadow(
          blurRadius: 44,
          color: primary,
          offset: Offset(5, 3),
        ),
      ],
    ),
  );
}
