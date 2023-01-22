import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';

import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.subjectController);

  final SubjectController subjectController;

  void addActivity(int subjectId, String activity, DateTime dateTime) {
    SubjectModel subject = subjectController.data.firstWhere(
      (subject) => subject.id == subjectId,
    );

    List<ActivityModel> activities = subject.activities;

    if (activities.length >= 50) return;

    activities.add(
      ActivityModel(activities.length + 1, activity, dateTime),
    );

    notifyListeners();
  }

  void removeActivity(int subjectId, int activityId) {
    SubjectModel subject = subjectController.data.firstWhere(
      (subject) => subject.id == subjectId,
    );

    subject.activities.removeWhere((activity) => activity.id == activityId);

    notifyListeners();
  }

  void editActivity(
    int subjectId,
    int activityId,
    String newActivity,
    DateTime newDateTime,
  ) {
    SubjectModel subject = subjectController.data.firstWhere(
      (subject) => subject.id == subjectId,
    );
    ActivityModel activity = subject.activities.firstWhere(
      (activity) => activity.id == activityId,
    );

    activity.activity = newActivity;
    activity.dateTime = newDateTime;

    notifyListeners();
  }
}
