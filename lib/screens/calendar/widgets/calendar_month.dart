import 'package:flutter/material.dart';
import 'calendar_day.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    super.key,
    required this.dayDate,
    required this.displayedMonth,
    required this.gridRatio,
  });

  final DateTime Function(int dayIndex) dayDate;
  final int displayedMonth;
  final double gridRatio;

  final double _gridSpacing = 8;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: _gridSpacing,
        mainAxisSpacing: _gridSpacing,
        childAspectRatio: gridRatio,
      ),
      itemCount: 42,
      itemBuilder: (context, dayIndex) {
        return CalendarDay(
          date: dayDate(dayIndex),
          isInDisplayedMonth: dayDate(dayIndex).month == displayedMonth,
        );
      },
    );
  }
}
