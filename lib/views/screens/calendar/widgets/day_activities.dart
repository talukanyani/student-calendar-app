import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/screens/add_activities/add_activities.dart';
import 'package:sc_app/views/widgets/activities_list.dart';
import '../state/selected_day.dart';

class DayActivities extends ConsumerWidget {
  const DayActivities({super.key});

  static final DateTime _today = DateTime.now();
  static final DateTime _tomorrow = _today.add(const Duration(days: 1));
  static final DateTime _yesterday = _today.subtract(const Duration(days: 1));

  String _weekDay(DateTime date) {
    if (Helpers.isSameDay(date, _today)) return 'Today';
    if (Helpers.isSameDay(date, _tomorrow)) return 'Tomorrow';
    if (Helpers.isSameDay(date, _yesterday)) return 'Yesterday';

    return Helpers.getFullWeekDayName(date.weekday - 1);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDayProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_weekDay(date)}, ${date.day}'
          ' ${Helpers.getFullMonthName(date.month - 1)}'
          ' ${date.year == _today.year ? '' : date.year}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Expanded(child: ActivitiesList(date: date)),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddActivityScreen(date: date),
              ),
            ),
            icon: const Icon(Iconsax.add_square),
          ),
        ),
      ],
    );
  }
}
