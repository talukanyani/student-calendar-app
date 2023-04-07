import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/data.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

final dataProvider =
    StateNotifierProvider<DataController, List<Subject>>((ref) {
  return DataController(ref);
});

final subjectsAndActivitiesProvider = Provider<List<Subject>>((ref) {
  final subjects = ref.watch(dataProvider);

  for (var subject in subjects) {
    subject.activities.sort((a, b) => a.date.compareTo(b.date));
  }

  return subjects;
});

final allActivitiesProvider = Provider<List<Activity>>((ref) {
  final subjects = ref.watch(dataProvider);

  List<Activity> activities = [];

  for (var subject in subjects) {
    for (var activity in subject.activities) {
      activities.add(activity);
    }
  }

  activities.sort((a, b) => a.date.compareTo(b.date));

  return activities;
});

Provider<List<Activity>> dayActivitiesProvider(DateTime date) {
  return Provider<List<Activity>>((ref) {
    final allActivities = ref.watch(allActivitiesProvider);

    final dayActivities = allActivities.where((activity) {
      return Helpers.isSameDay(activity.date, date);
    }).toList();

    dayActivities.sort((a, b) => a.date.compareTo(b.date));

    return dayActivities;
  });
}
