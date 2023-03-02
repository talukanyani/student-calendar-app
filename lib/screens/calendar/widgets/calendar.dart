import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'calendar_day.dart';
import 'week_day.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _displayedMonthIndex = _currMonthIndex;

  static DateTime currDate = DateTime.now();
  static int beforeCurrMonthCount = (currDate.month - 1) + 12;
  static final int _currMonthIndex = beforeCurrMonthCount;

  final double _gridSpacing = 8;
  final double _gridRatio = 0.8;

  DateTime getDate(dayIndex, monthIndex, weekStartDay) {
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
      currDate.month + (monthIndex - beforeCurrMonthCount),
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

  String displayedMonthName(int weekStartDay) {
    return getMonthFullName(displayedMonthDate(weekStartDay).month - 1);
  }

  String displayedMonthYear(int weekStartDay) {
    int year = displayedMonthDate(weekStartDay).year;
    if (year == currDate.year) return '';
    return year.toString();
  }

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
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${displayedMonthName(weekStartDay)} ${displayedMonthYear(weekStartDay)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          Container(
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
                return WeekDay(index: index);
              },
            ),
          ),
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
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: _gridSpacing,
                        mainAxisSpacing: _gridSpacing,
                        childAspectRatio: _gridRatio,
                      ),
                      itemCount: 42,
                      itemBuilder: (context, dayIndex) {
                        return DayBox(
                          date: getDate(dayIndex, monthIndex, weekStartDay),
                          isInDisplayedMonth:
                              getDate(dayIndex, monthIndex, weekStartDay)
                                      .month ==
                                  displayedMonthDate(weekStartDay).month,
                        );
                      },
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
