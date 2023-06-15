import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/utils/helpers.dart';
import '../state/displayed_month_date.dart';
import '../state/selected_day.dart';
import 'day_activities.dart';

class CalendarDay extends ConsumerStatefulWidget {
  const CalendarDay({super.key, required this.date});

  final DateTime date;

  @override
  ConsumerState<CalendarDay> createState() => _CalendarDayState();
}

class _CalendarDayState extends ConsumerState<CalendarDay> {
  bool get _isInDisplayedMonth =>
      widget.date.month == ref.watch(displayedMonthDateProvider).month;

  bool get _isToday => Helpers.isSameDay(widget.date, DateTime.now());

  bool get _isSelected =>
      Helpers.isSameDay(widget.date, ref.watch(selectedDayProvider));

  double getOpacity() {
    switch (ref.watch(dayActivitiesProvider(widget.date)).length) {
      case 0:
        return 0.00;
      case 1:
        return 0.32;
      case 2:
        return 0.48;
      case 3:
        return 0.64;
      case 4:
        return 0.80;
      default:
        return 0.96;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedDayProvider.notifier).change(widget.date);

        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: (240 + (MediaQuery.of(context).size.height * 0.2)),
              child: const DayActivities(),
            );
          },
        );
      },
      child: Opacity(
        opacity: _isInDisplayedMonth ? 1 : 0.25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(
                  getOpacity(),
                ),
            borderRadius: _isSelected
                ? BorderRadius.circular(16)
                : BorderRadius.circular(8),
            border: Border.all(
              width: _isToday ? 2 : 1,
              color: _isToday
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).dividerColor,
            ),
          ),
          child: Text(widget.date.day.toString()),
        ),
      ),
    );
  }
}
