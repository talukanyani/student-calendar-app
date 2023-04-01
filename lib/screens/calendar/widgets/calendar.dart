import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'displayed_month_name.dart';
import 'calendar_week_days.dart';
import 'calendar_month.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _displayedMonthIndex = _currMonthIndex;

  static DateTime currDate = DateTime.now();
  static int previousMonthCount = (currDate.month - 1) + 12;
  static final int _currMonthIndex = previousMonthCount;

  DateTime getDate(int dayIndex, int monthIndex, int weekStartDay) {
    if (monthIndex > _displayedMonthIndex) {
      return getNextMonthDates(dayIndex, monthIndex, weekStartDay);
    } else if (monthIndex < _displayedMonthIndex) {
      return getPrevMonthDates(dayIndex, monthIndex, weekStartDay);
    } else {
      return getDisplayedMonthDates(dayIndex, monthIndex, weekStartDay);
    }
  }

  DateTime getDisplayedMonthDates(
    int dayIndex,
    int monthIndex,
    int weekStartDay,
  ) {
    var displayedMonthFirstDate = DateTime(
      currDate.year,
      currDate.month + (monthIndex - previousMonthCount),
      1,
    );

    int difference() {
      int difference = displayedMonthFirstDate.weekday - weekStartDay;
      if (difference < 0) difference += 7;

      return difference;
    }

    // startDate is the first date in the first week of the month
    // it should be on mon/sun/sat depending on weekStartDay setting
    var startDate = displayedMonthFirstDate.subtract(
      Duration(days: difference()),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getNextMonthDates(int dayIndex, int monthIndex, int weekStartDay) {
    var displayedMonthLastDate =
        getDisplayedMonthDates(41, _displayedMonthIndex, weekStartDay);

    var startDate = displayedMonthLastDate.add(
      Duration(days: 1 + (42 * (monthIndex - (_displayedMonthIndex + 1)))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getPrevMonthDates(int dayIndex, int monthIndex, int weekStartDay) {
    var displayedMounthFirstDate =
        getDisplayedMonthDates(0, _displayedMonthIndex, weekStartDay);

    var startDate = displayedMounthFirstDate.subtract(
      Duration(days: 42 + (42 * ((_displayedMonthIndex - 1) - monthIndex))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime displayedMonthDate(int weekStartDay) {
    return getDate(7, _displayedMonthIndex, weekStartDay);
  }

  final double _gridRatio = 0.8;

  double getViewFraction(constraints) {
    double pageViewHeight = constraints.maxHeight;
    double pageViewWidth = constraints.maxWidth;

    double monthHeight = (((pageViewWidth / 7) * (1 / _gridRatio)) * 6);

    double fraction = monthHeight / pageViewHeight;

    if (fraction > 1 || fraction <= 0) {
      return 1;
    }

    return fraction;
  }

  @override
  Widget build(BuildContext context) {
    final weekStartDay = Provider.of<SettingController>(context).weekStartDay;

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.all(Radius.elliptical(16, 32)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 16,
            spreadRadius: -8,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          DisplayedMonthName(monthDate: displayedMonthDate(weekStartDay)),
          const SizedBox(height: 16),
          const CalendarWeekDays(),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  controller: PageController(
                    initialPage: _currMonthIndex,
                    viewportFraction: getViewFraction(constraints),
                  ),
                  padEnds: false,
                  onPageChanged: (index) {
                    setState(() => _displayedMonthIndex = index);
                  },
                  itemCount: 48,
                  itemBuilder: (context, monthIndex) {
                    return CalendarMonth(
                      dayDate: (dayIndex) {
                        return getDate(dayIndex, monthIndex, weekStartDay);
                      },
                      displayedMonth: displayedMonthDate(weekStartDay).month,
                      gridRatio: _gridRatio,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
