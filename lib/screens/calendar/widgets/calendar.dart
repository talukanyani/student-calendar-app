import 'package:flutter/material.dart';
import 'package:sc_app/screens/calendar/widgets/calendar_day.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _currPageIndex = 6;
  final double _gridSpacing = 4;
  final double _gridRatio = 0.75;
  final DateTime currDate = DateTime.now();

  // if it is currently displayed month, get its dates using dates algorithim
  // else get its dates using first or last date of currently diplayed month.
  DateTime getDate(dayIndex, monthIndex) {
    if (monthIndex > _currPageIndex) {
      return getNextMonthDate(dayIndex, monthIndex);
    } else if (monthIndex < _currPageIndex) {
      return getPrevMonthDate(dayIndex, monthIndex);
    } else {
      return getDisplayedMonthDate(dayIndex, monthIndex);
    }
  }

  DateTime getDisplayedMonthDate(int dayIndex, int monthIndex) {
    var startDate = DateTime(
      currDate.year,
      currDate.month + (monthIndex - 6),
      1,
    );

    // for start date to be Monday date
    startDate = startDate.subtract(
      Duration(days: (startDate.weekday - DateTime.monday)),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getNextMonthDate(int dayIndex, int monthIndex) {
    var displayedMonthLastDate = getDisplayedMonthDate(41, _currPageIndex);

    var startDate = displayedMonthLastDate.add(
      Duration(days: 1 + (42 * (monthIndex - (_currPageIndex + 1)))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  DateTime getPrevMonthDate(int dayIndex, int monthIndex) {
    var displyedMounthFirstDate = getDisplayedMonthDate(0, _currPageIndex);

    var startDate = displyedMounthFirstDate.subtract(
      Duration(days: 42 + (42 * ((_currPageIndex - 1) - monthIndex))),
    );

    return startDate.add(Duration(days: dayIndex));
  }

  bool isCurrentDate(dayIndex, monthIndex) {
    var dayBox = getDate(dayIndex, monthIndex);

    if (dayBox.day == currDate.day &&
        dayBox.month == currDate.month &&
        dayBox.year == currDate.year) {
      return true;
    } else {
      return false;
    }
  }

  // get month view ratio to available space using avilable space height
  // and month view height
  double getViewFraction(constraints) {
    double gridSpaces(no) => _gridSpacing * no;

    double pageViewHeight = constraints.maxHeight;
    double pageViewWidth = constraints.maxWidth;

    double dayBoxWidth = (pageViewWidth - gridSpaces(6)) / 7;
    double dayBoxHeight = dayBoxWidth * (1 / _gridRatio);

    double monthHeight = (dayBoxHeight * 6) + gridSpaces(5);

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
            blurRadius: 32,
            spreadRadius: -28,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'February 2023',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
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
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  controller: PageController(
                    initialPage: 6,
                    viewportFraction: getViewFraction(constraints),
                  ),
                  padEnds: false,
                  onPageChanged: (index) {
                    setState(() => _currPageIndex = index);
                  },
                  itemCount: 20,
                  itemBuilder: (context, monthIndex) {
                    if (monthIndex == 19) {
                      return SizedBox(height: constraints.maxHeight);
                    }
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
                          isCurrentDate: isCurrentDate(dayIndex, monthIndex),
                          isInDisplayedMonth:
                              getDate(dayIndex, monthIndex).month ==
                                  getDate(7, _currPageIndex).month,
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
