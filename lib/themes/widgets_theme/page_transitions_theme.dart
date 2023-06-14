import 'package:flutter/material.dart';

PageTransitionsTheme pageTransitionsTheme() {
  return const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );
}
