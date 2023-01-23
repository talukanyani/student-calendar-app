import 'package:flutter/material.dart';

import 'package:sc_app/screens/add/add.dart';
import 'package:sc_app/screens/calendar/calendar.dart';

class WeekActivities extends StatelessWidget {
  const WeekActivities({super.key, required this.activitiesCount});

  final int activitiesCount;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('You have $activitiesCount activities this week'),
          const SizedBox(height: 16),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalendarScreen()),
                );
              },
              child: const Text('View Calendar'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 32,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddScreen()),
                );
              },
              child: const Text('Add Activities'),
            ),
          ),
        ],
      ),
    );
  }
}
