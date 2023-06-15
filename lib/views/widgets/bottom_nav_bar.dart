import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:sc_app/views/screens/calendar/calendar.dart';
import 'package:sc_app/views/screens/home/home.dart';
import 'package:sc_app/views/screens/tables/tables.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({required this.screenIndex, super.key});

  final int screenIndex;

  static const List<Widget> _primaryScreens = <Widget>[
    HomeScreen(),
    TablesScreen(),
    CalendarScreen(),
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
          return;
        }

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => _primaryScreens[index]),
          (route) => route.isFirst,
        );
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.home_24_regular),
          activeIcon: Icon(FluentIcons.home_24_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.table_24_regular),
          activeIcon: Icon(FluentIcons.table_24_filled),
          label: 'Tables',
        ),
        BottomNavigationBarItem(
          icon: Icon(FluentIcons.calendar_ltr_24_regular),
          activeIcon: Icon(FluentIcons.calendar_ltr_24_filled),
          label: 'Calendar',
        ),
      ],
    );
  }
}
