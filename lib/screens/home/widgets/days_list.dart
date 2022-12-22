import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DaysList extends StatelessWidget {
  const DaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(
          left: 16,
          right: 8,
        ),
        children: const [
          DayBox(day: 'Wed', date: '1'),
          DayBox(day: 'Thu', date: '2'),
          DayBox(day: 'Fri', date: '3'),
          DayBox(day: 'Sat', date: '4'),
          DayBox(day: 'Sun', date: '5'),
          DayBox(day: 'Mon', date: '6'),
          DayBox(day: 'Tue', date: '7'),
          ButtonBox()
        ],
      ),
    );
  }
}

class DayBox extends StatelessWidget {
  const DayBox({
    super.key,
    required this.day,
    required this.date,
  });

  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 48,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.headline5?.color,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).textTheme.headline5?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonBox extends StatelessWidget {
  const ButtonBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'View full calender',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).textTheme.headline5?.color,
            ),
          ),
          Icon(
            Iconsax.arrow_right_2,
            size: 24,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ],
      ),
    );
  }
}
