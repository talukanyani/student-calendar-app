import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/services/database.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.data);

  final List<SubjectModel> data;

  SubjectModel subject(int subjectTimeId) {
    return data.firstWhere((subject) => subject.timeId == subjectTimeId);
  }

  List<ActivityModel> subjectActivities(int subjectTimeId) {
    var activities = subject(subjectTimeId).activities;
    activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return activities;
  }

  List<ActivityModel> get allActivities {
    List<ActivityModel> activities = [];

    for (var subject in data) {
      for (var activity in subject.activities) {
        activities.add(
          ActivityModel(
            timeId: activity.timeId,
            docId: activity.docId,
            subjectName: subject.name,
            activity: activity.activity,
            dateTime: activity.dateTime,
          ),
        );
      }
    }

    activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return activities;
  }

  List<ActivityModel> dayActivities(DateTime dayDate) {
    var dayActivities = allActivities.where((activity) {
      return Helpers.isSameDay(activity.dateTime, dayDate);
    });

    return dayActivities.toList();
  }

  void addActivity(
    int subjectTimeId,
    int activityTimeId,
    String activity,
    DateTime dateTime,
  ) {
    var activities = subject(subjectTimeId).activities;

    if (activities.length >= 50) return;

    activities.add(
      ActivityModel(
        timeId: activityTimeId,
        subjectName: subject(subjectTimeId).name,
        activity: activity,
        dateTime: dateTime,
      ),
    );

    notifyListeners();

    Database().addActivity(subjectTimeId, activityTimeId, activity, dateTime);
  }

  void removeActivity(int subjectTimeId, int activityTimeId) {
    var activities = subject(subjectTimeId).activities;
    var activity = activities.firstWhere((activity) {
      return activity.timeId == activityTimeId;
    });

    activities.remove(activity);

    notifyListeners();

    Database().deleteActivity(subjectTimeId, activityTimeId);
  }

  void editActivity(
    int subjectTimeId,
    int activityTimeId,
    String newActivity,
    DateTime newDateTime,
  ) {
    var oldActivity = subject(subjectTimeId).activities.firstWhere((activity) {
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
