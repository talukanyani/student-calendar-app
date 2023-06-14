import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/data.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

final dataProvider =
    StateNotifierProvider<DataController, List<Subject>>((ref) {
  return DataController(ref);
});

final subjectsAndActivitiesProvider = Provider<List<Subject>>((ref) {
  final subjects = ref.watch(dataProvider);

  for (var subject in subjects) {
    subject.activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));
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

  activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));

  return activities;
});

Provider<List<Activity>> dayActivitiesProvider(DateTime date) {
  return Provider<List<Activity>>((ref) {
    final allActivities = ref.watch(allActivitiesProvider);

    final dayActivities = allActivities.where((activity) {
      return Helpers.isSameDay(activity.dateTime, date);
    }).toList();

    dayActivities.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return dayActivities;
  });
}

Provider<Subject> subjectProvider(int subjectId) {
  return Provider<Subject>((ref) {
    final subjects = ref.watch(subjectsAndActivitiesProvider);
    return subjects.firstWhere((subject) => subject.id == subjectId);
  });
}
