import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'calendar_week_days.dart';
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

  static final _currentMonthIndex =
      (_yearsBeforeCurrentYear * _monthsInAYear) + (DateTime.now().month - 1);
  static final _calendarFirstDate =
      DateTime(DateTime.now().year - _yearsBeforeCurrentYear);

  DateTime get _displayedMonthDate => DateTime(
        _calendarFirstDate.year,
        _calendarFirstDate.month + _displayedMonthIndex,
      );

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
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
          DisplayedMonthTitle(month: _displayedMonthDate),
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
                    initialPage: _currentMonthIndex,
                    viewportFraction: getViewFraction(constraints),
                  ),
                  padEnds: false,
                  onPageChanged: (index) {
                    setState(() => _displayedMonthIndex = index);
                  },
                  itemCount:
                      (_yearsBeforeCurrentYear + 1 + _yearsAfterCurrentYear) *
                          _monthsInAYear,
                  itemBuilder: (context, monthIndex) {
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
                        final dates = getMonthDates(monthIndex);

                        return CalendarDay(
                          date: dates[dayIndex],
                          isInDisplayedMonth: dates[dayIndex].month ==
                              _displayedMonthDate.month,
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

class DisplayedMonthTitle extends StatelessWidget {
  const DisplayedMonthTitle({super.key, required this.month});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '${getMonthFullName(month.month - 1)} '
        '${month.year == DateTime.now().year ? '' : month.year}',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
