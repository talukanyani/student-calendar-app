import 'package:flutter/material.dart';
import 'package:sc_app/screens/calendar/widgets/calendar_day.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  int getDate(int index) {
    int date = 30 + index;

    if (date <= 31) {
      return date;
    } else if (date <= 59) {
      return date - 31;
    } else if (date <= 90) {
      return date - 59;
    } else {
      return date - 90;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: const BorderRadius.all(Radius.elliptical(16, 32)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 32,
            spreadRadius: -28,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'February 2023',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.width / 7,
            child: GridView.count(
              crossAxisCount: 7,
              children: const [
                WeekDay(day: 'Mon'),
                WeekDay(day: 'Tue'),
                WeekDay(day: 'Wed'),
                WeekDay(day: 'Thu'),
                WeekDay(day: 'Fri'),
                WeekDay(day: 'Sat'),
                WeekDay(day: 'Sun'),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: 70,
              itemBuilder: (context, index) {
                return Day(
                  date: getDate(index),
                  isCurrentDate: index == 2,
                  activities: index == 14
                      ? const ['Activity1', 'Activity2']
                      : index == 15
                          ? const ['Activity1']
                          : index == 22
                              ? const ['Activity1']
                              : index == 49
                                  ? const ['Activity1']
                                  : index == 55
                                      ? const ['Activity1']
                                      : const [],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
