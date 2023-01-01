import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

import 'package:sc_app/screens/home/home.dart';
import 'package:sc_app/screens/add/add.dart';
import 'package:sc_app/screens/calender/calender.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.screenIndex, super.key});

  final int screenIndex;

  static const List<Widget> _primaryScreens = <Widget>[
    HomeScreen(),
    AddScreen(),
    CalenderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: screenIndex,
      onTap: (int index) {
        if (index == screenIndex) return;

        if (index == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => _primaryScreens[index],
            ),
            (route) => route.isFirst,
          );
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.home_24_regular),
          activeIcon: Icon(FluentIcons.home_24_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.add_circle_24_regular),
          activeIcon: Icon(FluentIcons.add_circle_24_filled),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.calendar_ltr_24_regular),
          activeIcon: Icon(FluentIcons.calendar_ltr_24_filled),
          label: 'Calender',
        ),
      ],
    );
  }
}
