import 'package:flutter/material.dart';
import 'package:sc_app/screens/calendar/modals/day_activities.dart';

class Day extends StatelessWidget {
  const Day({
    super.key,
    required this.date,
    this.activities = const [],
    this.isCurrentDate = false,
    this.isInDisplayedMonth = true,
  });

  final int date;
  final List activities;
  final bool isCurrentDate;
  final bool isInDisplayedMonth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        barrierColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.1),
        context: context,
        builder: (context) => const DayActivitiesModal(),
      ),
      child: Opacity(
        opacity: isInDisplayedMonth ? 1 : 0.25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: activities.isNotEmpty
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: isCurrentDate ? 4 : 1,
              color: isCurrentDate
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).dividerColor,
            ),
          ),
          child: Text(date.toString()),
        ),
      ),
    );
  }
}

class WeekDay extends StatelessWidget {
  const WeekDay({super.key, required this.day});

  final String day;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        day,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline5?.color,
        ),
      ),
    );
  }
}
