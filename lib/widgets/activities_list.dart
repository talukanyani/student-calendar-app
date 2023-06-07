import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/providers/data.dart';

class ActivitiesList extends ConsumerWidget {
  const ActivitiesList({super.key, required this.date});

  final DateTime date;

  static final today = DateTime.now();
  static final tomorrow = today.add(const Duration(days: 1));
  static final yesterday = today.subtract(const Duration(days: 1));

  String get dateWord {
    if (Helpers.isSameDay(date, today)) return 'today';
    if (Helpers.isSameDay(date, tomorrow)) return 'tomorrow';
    if (Helpers.isSameDay(date, yesterday)) return 'yesterday';
    return 'on this day';
  }

  String get verb {
    if (date.isBefore(DateTime(today.year, today.month, today.day))) {
      return 'had';
    }
    return 'have';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activities = ref.watch(dayActivitiesProvider(date));

    if (activities.isEmpty) {
      return Center(
        child: TextBox(text: 'You $verb no activity $dateWord'),
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
              TextBox(
                text: TimeOfDay(
                  hour: activities[index].date.hour,
                  minute: activities[index].date.minute,
                ).format(context),
              ),
              index == (activities.length - 1)
                  ? const SizedBox(height: 12)
                  : const VertLine(),
            ],
          ),
          title: Text(
            '${activities[index].subjectName} ${activities[index].title}',
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
      color: Theme.of(context).colorScheme.primaryContainer,
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
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }
}
