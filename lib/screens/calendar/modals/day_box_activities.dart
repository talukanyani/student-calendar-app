import 'package:flutter/material.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/activities_list.dart';
import 'package:sc_app/widgets/modal.dart';

class DayBoxActivitiesModal extends StatelessWidget {
  const DayBoxActivitiesModal({
    super.key,
    required this.date,
    required this.activities,
  });

  final DateTime date;
  final List<ActivityModel> activities;

  String get title {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (Helpers.isSameDay(date, today)) return 'Today';
    if (Helpers.isSameDay(date, tomorrow)) return 'Tomorrow';
    return getWeekDayFullName(date.weekday - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      insetPadding: 32,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$title, ${date.day} ${getMonthFullName(date.month - 1)}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ActivitiesList(activities: activities, date: date),
            ),
          ],
        ),
      ],
    );
  }
}
