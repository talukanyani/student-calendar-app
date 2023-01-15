import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidSystemNavbarStyle extends StatelessWidget {
  const AndroidSystemNavbarStyle({
    super.key,
    required this.color,
    this.iconsBrightness,
    required this.child,
  });

  final Color color;
  final Brightness? iconsBrightness;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: color,
        systemNavigationBarDividerColor: color,
        systemNavigationBarIconBrightness: iconsBrightness ?? Brightness.dark,
      ),
      child: child,
    );
  }
}
