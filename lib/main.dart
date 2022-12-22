import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sc_app/themes/theme.dart';
import 'package:sc_app/themes/system_theme/system_theme.dart';

import 'package:sc_app/screens/home/home.dart';
import 'package:sc_app/screens/add/add.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: androidSystemOverlay(),
      child: MaterialApp(
        title: 'Student Calender',
        home: const HomeScreen(),
        // home: const AddScreen(),
        theme: lightTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
