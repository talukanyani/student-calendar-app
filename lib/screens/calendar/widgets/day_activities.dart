import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/activities_list.dart';
import '../state/selected_day.dart';

class DayActivities extends ConsumerWidget {
  const DayActivities({super.key});

  static final DateTime today = DateTime.now();
  static final DateTime tomorrow = today.add(const Duration(days: 1));

  String weekDay(DateTime date) {
    if (Helpers.isSameDay(date, today)) return 'Today';
    if (Helpers.isSameDay(date, tomorrow)) return 'Tomorrow';
    return getWeekDayFullName(date.weekday - 1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDayProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${weekDay(date)}, ${date.day} ${getMonthFullName(date.month - 1)}'
          ' ${date.year == today.year ? '' : date.year}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Expanded(child: ActivitiesList(date: date)),
      ],
    );
  }
}
