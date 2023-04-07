import 'package:flutter/material.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/activities_list.dart';
import 'package:sc_app/widgets/modal.dart';

class DayActivitiesModal extends StatelessWidget {
  const DayActivitiesModal({super.key, required this.date});

  final DateTime date;

  String get weekDay {
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
                '$weekDay, ${date.day} ${getMonthFullName(date.month - 1)} '
                '${date.year == DateTime.now().year ? '' : date.year}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ActivitiesList(date: date),
            ),
          ],
        ),
      ],
    );
  }
}
