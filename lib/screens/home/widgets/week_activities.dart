import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/screens/calendar/calendar.dart';
import 'package:sc_app/screens/tables/tables.dart';

class WeekActivities extends ConsumerWidget {
  const WeekActivities({super.key});

  int next7daysActivitiesCount(WidgetRef ref) {
    int activitiesCount = 0;

    for (var i = 0; i < 7; i++) {
      var dayActivities = ref.watch(dayActivitiesProvider(
        DateTime.now().add(Duration(days: i)),
      ));

      activitiesCount += dayActivities.length;
    }

    return activitiesCount;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You have ${next7daysActivitiesCount(ref) == 0 ? 'no' : next7daysActivitiesCount(ref)} '
            '${next7daysActivitiesCount(ref) < 1 ? 'activity' : 'activities'} this week',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CalendarScreen(),
                ),
              ),
              child: const Text('View Calendar'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TablesScreen(),
                ),
              ),
              child: const Text('Add Activities'),
            ),
          ),
        ],
      ),
    );
  }
}
