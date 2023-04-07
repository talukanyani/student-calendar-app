import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import '../modals/day_activities.dart';

class CalendarDay extends ConsumerWidget {
  const CalendarDay({
    super.key,
    required this.date,
    this.isInDisplayedMonth = true,
  });

  final DateTime date;
  final bool isInDisplayedMonth;

  bool get isToday => Helpers.isSameDay(date, DateTime.now());

  double getOpacity(int activitiesCount) {
    switch (activitiesCount) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(dayActivitiesProvider(date));

    return GestureDetector(
      onTap: () => Show.modal(
        context,
        modal: DayActivitiesModal(date: date),
      ),
      child: Opacity(
        opacity: isInDisplayedMonth ? 1 : 0.25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(
                  getOpacity(activities.length),
                ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: isToday ? 4 : 1,
              color: isToday
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).dividerColor,
            ),
          ),
          child: Text(date.day.toString()),
        ),
      ),
    );
  }
}
