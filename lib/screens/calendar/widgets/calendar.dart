import 'package:flutter/material.dart';

import 'package:sc_app/helpers/month_names.dart';

import 'calendar_day.dart';

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

  // if it is currently displayed month, get its dates using dates algorithim
  // else get its dates using first or last date of currently diplayed month.
  DateTime getDate(dayIndex, monthIndex) {
    if (monthIndex > _displayedMonthIndex) {
      return getNextMonthDates(dayIndex, monthIndex);
    } else if (monthIndex < _displayedMonthIndex) {
      return getPrevMonthDates(dayIndex, monthIndex);
    } else {
      return getDisplayedMonthDates(dayIndex, monthIndex);
    }
  }

  DateTime getDisplayedMonthDates(int dayIndex, int monthIndex) {
    var startDate = DateTime(
      currDate.year,
      currDate.month + (monthIndex - beforeCurrMonthCount),
      1,
    );

    // for start date to be Monday date
    startDate = startDate.subtract(
      Duration(days: (startDate.weekday - DateTime.monday)),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getNextMonthDates(int dayIndex, int monthIndex) {
    var displayedMonthLastDate =
        getDisplayedMonthDates(41, _displayedMonthIndex);

    var startDate = displayedMonthLastDate.add(
      Duration(days: 1 + (42 * (monthIndex - (_displayedMonthIndex + 1)))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getPrevMonthDates(int dayIndex, int monthIndex) {
    var displayedMounthFirstDate =
        getDisplayedMonthDates(0, _displayedMonthIndex);

    var startDate = displayedMounthFirstDate.subtract(
      Duration(days: 42 + (42 * ((_displayedMonthIndex - 1) - monthIndex))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  bool isCurrDate(dayIndex, monthIndex) {
    var dayBox = getDate(dayIndex, monthIndex);

    if (dayBox.day == currDate.day &&
        dayBox.month == currDate.month &&
        dayBox.year == currDate.year) {
      return true;
    } else {
      return false;
    }
  }

  DateTime displayedMonthDate() {
    return getDate(7, _displayedMonthIndex);
  }

  String displayedMonthName() {
    return getFullMonthName(displayedMonthDate().month - 1);
  }

  String displayedMonthYear() {
    int year = displayedMonthDate().year;

    if (year == currDate.year) {
      return '';
    }

    return year.toString();
  }

  // get month view ratio to available space using avilable space height
  // and month view height
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
              '${displayedMonthName()} ${displayedMonthYear()}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GridView.count(
              shrinkWrap: true,
              childAspectRatio: 1.25,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 7,
              children: const [
                WeekDay(day: 'Mon'),
                WeekDay(day: 'Tue'),
                WeekDay(day: 'Wed'),
                WeekDay(day: 'Thu'),
                WeekDay(day: 'Fri'),
                WeekDay(day: 'Sat'),
                WeekDay(day: 'Sun'),
              ],
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
                        return Day(
                          date: getDate(dayIndex, monthIndex).day,
                          isCurrentDate: isCurrDate(dayIndex, monthIndex),
                          isInDisplayedMonth:
                              getDate(dayIndex, monthIndex).month ==
                                  displayedMonthDate().month,
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
