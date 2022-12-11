import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.screenIndex, super.key});

  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: screenIndex,
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
