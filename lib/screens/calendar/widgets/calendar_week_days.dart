import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/calendar_names.dart';

class CalendarWeekDays extends StatelessWidget {
  const CalendarWeekDays({super.key});

  int getWeekNameIndex(int index, int weekStartDay) {
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

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.25,
        ),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              getWeekDayName(getWeekNameIndex(index, weekStartDay)),
            ),
          );
        },
      ),
    );
  }
}
