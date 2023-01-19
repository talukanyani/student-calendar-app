import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';

import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.subjectController);

  final SubjectController subjectController;

  void addActivity(int subjectId, String activity, DateTime dateTime) {
    SubjectModel subject = subjectController.subjectData.firstWhere(
      (subject) => subject.id == subjectId,
    );

    List<ActivityModel> activities = subject.activities;

    activities.add(
      ActivityModel(activities.length + 1, activity, dateTime),
    );

    notifyListeners();
  }
}
