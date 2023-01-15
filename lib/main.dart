import 'package:flutter/material.dart';

import 'package:sc_app/themes/theme.dart';
import 'package:sc_app/themes/color_scheme.dart';

import '/widgets/android_system_navbar.dart';
import '/screens/home/home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.background5,
      child: MaterialApp(
        title: 'Student Calendar',
        home: const HomeScreen(),
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
