import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/calendar_names.dart';

class WeekDay extends StatelessWidget {
  const WeekDay({super.key, required this.index});

  final int index;

  int getWeekNameIndex(int weekStartDay) {
    int weekNameIndex = index;

    switch (weekStartDay) {
      case DateTime.monday:
        break;
      case DateTime.sunday:
        weekNameIndex -= 1;
        if (weekNameIndex < 0) weekNameIndex += 7;
        break;
      case DateTime.saturday:
        weekNameIndex -= 2;
        if (weekNameIndex < 0) weekNameIndex += 7;
        break;
    }

    return weekNameIndex;
  }

  @override
  Widget build(BuildContext context) {
    final weekStartDay = Provider.of<SettingController>(context).weekStartDay;

    return Center(
      child: Text(getWeekDayName(getWeekNameIndex(weekStartDay))),
    );
  }
}
