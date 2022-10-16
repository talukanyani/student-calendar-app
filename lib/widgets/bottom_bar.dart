import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.screenIndex, super.key});

  final int screenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month_outlined),
          label: 'Calender',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_applications_outlined),
          label: 'Settings',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      currentIndex: screenIndex,
    );
  }
}
