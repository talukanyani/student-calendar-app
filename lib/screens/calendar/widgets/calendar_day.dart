import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import '../modals/day_box_activities.dart';

class DayBox extends StatefulWidget {
  const DayBox({
    super.key,
    required this.date,
    this.isInDisplayedMonth = true,
  });

  final DateTime date;
  final bool isInDisplayedMonth;

  @override
  State<DayBox> createState() => _DayBoxState();
}

class _DayBoxState extends State<DayBox> {
  bool buttonSplash = false;

  bool get isToday => Helpers.isSameDay(widget.date, DateTime.now());

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
  Widget build(BuildContext context) {
    final activitiesController = Provider.of<ActivityController>(context);
    final activities = activitiesController.dayActivities(widget.date);

    return GestureDetector(
      onTap: () => Show.modal(
        context,
        modal: DayBoxActivitiesModal(
          date: widget.date,
          activities: activities,
        ),
      ),
      onTapDown: (_) => setState(() => buttonSplash = true),
      onTapUp: (_) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() => buttonSplash = false),
        );
      },
      onTapCancel: () => setState(() => buttonSplash = false),
      child: Opacity(
        opacity: widget.isInDisplayedMonth ? 1 : 0.25,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary.withOpacity(
                  getOpacity(activities.length),
                ),
            boxShadow: buttonSplash
                ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      blurRadius: 8,
                      spreadRadius: 8,
                    ),
                  ]
                : null,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: isToday ? 4 : 1,
              color: isToday
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
