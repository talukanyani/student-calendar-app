import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import '../state/displayed_month_date.dart';
import 'week_days_bar.dart';
import 'calendar_day.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  int _displayedMonthIndex = _currentMonthIndex;

  static const _yearsBeforeCurrentYear = 100;
  static const _yearsAfterCurrentYear = 99;
  static const _monthsInAYear = 12;
  static const _monthColumns = 7;
  static const _monthRows = 6;
  static const _monthGridSquares = _monthColumns * _monthRows;
  static const _gridRatio = 0.9;

  static final _currentDate = DateTime.now();
  static final _currentMonthIndex =
      (_yearsBeforeCurrentYear * _monthsInAYear) + (_currentDate.month - 1);
  static final _calendarFirstDate =
      DateTime(_currentDate.year - _yearsBeforeCurrentYear);

  List<DateTime> getMonthDates(int index) {
    if (index > _displayedMonthIndex) {
      return getNextMonthDates(index);
    } else if (index < _displayedMonthIndex) {
      return getPrevMonthDates(index);
    } else {
      return getDisplayedMonthDates(index);
    }
  }

  List<DateTime> getDisplayedMonthDates(int index) {
    var monthFirstDate = DateTime(
      _calendarFirstDate.year,
      _calendarFirstDate.month + index,
    );

    // For first date to be at the start of the week
    while (monthFirstDate.weekday != ref.watch(weekStartProvider)) {
      monthFirstDate = monthFirstDate.subtract(const Duration(days: 1));
    }

    List<DateTime> monthDates = [];

    for (var i = 0; i < _monthGridSquares; i++) {
      monthDates.add(monthFirstDate.add(Duration(days: i)));
    }

    return monthDates;
  }

  List<DateTime> getNextMonthDates(int index) {
    final displayedMonthLastDate = getDisplayedMonthDates(
      _displayedMonthIndex,
    )[_monthGridSquares - 1];

    final startDate = displayedMonthLastDate.add(
      Duration(
        days: 1 + (_monthGridSquares * (index - (_displayedMonthIndex + 1))),
      ),
    );

    List<DateTime> monthDates = [];

    for (var i = 0; i < _monthGridSquares; i++) {
      monthDates.add(startDate.add(Duration(days: i)));
    }

    return monthDates;
  }

  List<DateTime> getPrevMonthDates(int index) {
    final displayedMonthFirstDate = getDisplayedMonthDates(
      _displayedMonthIndex,
    )[0];

    final startDate = displayedMonthFirstDate.subtract(
      Duration(
        days: _monthGridSquares +
            (_monthGridSquares * ((_displayedMonthIndex - 1) - index)),
      ),
    );

    List<DateTime> monthDates = [];

    for (var i = 0; i < _monthGridSquares; i++) {
      monthDates.add(startDate.add(Duration(days: i)));
    }
    return monthDates;
  }

  double getViewFraction(BoxConstraints constraints) {
    final pageViewHeight = constraints.maxHeight;
    final pageViewWidth = constraints.maxWidth;

    final monthHeight =
        (((pageViewWidth / _monthColumns) * (1 / _gridRatio)) * _monthRows);

    var fraction = monthHeight / pageViewHeight;

    if (fraction > 1 || fraction <= 0) fraction = 1;

    return fraction;
  }

  @override
  void initState() {
    Future(() {
      ref.read(displayedMonthDateProvider.notifier).change(
            DateTime(
              _calendarFirstDate.year,
              _calendarFirstDate.month + _displayedMonthIndex,
            ),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        children: [
          const WeekDaysBar(),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  controller: PageController(
                    initialPage: _currentMonthIndex,
                    viewportFraction: getViewFraction(constraints),
                  ),
                  padEnds: false,
                  onPageChanged: (index) {
                    setState(() => _displayedMonthIndex = index);
                    ref.read(displayedMonthDateProvider.notifier).change(
                          DateTime(
                            _calendarFirstDate.year,
                            _calendarFirstDate.month + index,
                          ),
                        );
                  },
                  itemCount:
                      (_yearsBeforeCurrentYear + 1 + _yearsAfterCurrentYear) *
                          _monthsInAYear,
                  itemBuilder: (context, monthIndex) {
                    final monthDates = getMonthDates(monthIndex);

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _monthColumns,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: _gridRatio,
                      ),
                      itemCount: _monthGridSquares,
                      itemBuilder: (context, dayIndex) {
                        return CalendarDay(
                          date: monthDates[dayIndex],
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
