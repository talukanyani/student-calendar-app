import 'package:flutter/material.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/models/activity.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({
    super.key,
    required this.date,
    required this.activities,
  });

  final DateTime date;
  final List<ActivityModel> activities;

  String get dateWord {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(const Duration(days: 1));

    if (Helpers.isSameDay(date, today)) return 'today';
    if (Helpers.isSameDay(date, tomorrow)) return 'tomorrow';
    return 'on this day';
  }

  TimeOfDay getTime(index) {
    DateTime date = activities[index].dateTime;
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return Center(
        child: TextBox(text: 'You have no activity $dateWord'),
      );
    }

    return ListView.builder(
      primary: false,
      physics: const BouncingScrollPhysics(),
      itemExtent: 48,
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Column(
            children: <Widget>[
              index == 0 ? const SizedBox(height: 12) : const VertLine(),
              TextBox(text: getTime(index).format(context)),
              index == (activities.length - 1)
                  ? const SizedBox(height: 12)
                  : const VertLine(),
            ],
          ),
          title: Text(
            '${activities[index].subjectName} ${activities[index].activity}',
          ),
        );
      },
    );
  }
}

class VertLine extends StatelessWidget {
  const VertLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 2,
      color: Theme.of(context).primaryColorLight,
    );
  }
}

class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }
}
