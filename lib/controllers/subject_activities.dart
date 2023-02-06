import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/services/database.dart';

class SubjectActivitiesController extends ChangeNotifier {
  SubjectActivitiesController(this.subjectController);

  final SubjectController subjectController;

  void addActivity(
    int subjectTimeId,
    int activityTimeId,
    String activity,
    DateTime dateTime,
  ) {
    SubjectModel subject = subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });

    List<ActivityModel> activities = subject.activities;

    if (activities.length >= 50) return;

    activities.add(
      ActivityModel(
        timeId: activityTimeId,
        subjectName: subject.name,
        activity: activity,
        dateTime: dateTime,
      ),
    );

    notifyListeners();

    Database().addActivity(subjectTimeId, activityTimeId, activity, dateTime);
  }

  void removeActivity(int subjectTimeId, int activityTimeId) {
    SubjectModel subject = subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });

    ActivityModel activity = subject.activities.firstWhere((activity) {
      return activity.timeId == activityTimeId;
    });

    subject.activities.remove(activity);

    notifyListeners();

    Database().deleteActivity(subjectTimeId, activityTimeId);
  }

  void editActivity(
    int subjectTimeId,
    int activityTimeId,
    String newActivity,
    DateTime newDateTime,
  ) {
    SubjectModel subject = subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });

    ActivityModel oldActivity = subject.activities.firstWhere((activity) {
      return activity.timeId == activityTimeId;
    });

    oldActivity.activity = newActivity;
    oldActivity.dateTime = newDateTime;

    notifyListeners();

    Database().editActivity(
      subjectTimeId,
      activityTimeId,
      newActivity,
      newDateTime,
    );
  }
}
