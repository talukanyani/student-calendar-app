import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/services/database.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.subjectController);

  final SubjectController subjectController;

  List<ActivityModel> _activitiesData(int subjectTimeId) {
    var subject = subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });
    return subject.activities;
  }

  List<ActivityModel> _activitiesCacheDb(int subjectTimeId) {
    var subject = subjectController.cacheDb.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });
    return subject.activities;
  }

  Database? _syncDb() => subjectController.syncDb();

  List<ActivityModel> subjectActivities(int subjectTimeId) {
    var activities = _activitiesData(subjectTimeId);
    activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return activities;
  }

  List<ActivityModel> get allActivities {
    List<ActivityModel> activities = [];

    for (var subject in subjectController.data) {
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
    var subject = subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    });

    if (_activitiesData(subjectTimeId).length >= 50) return;

    _activitiesCacheDb(subjectTimeId).add(
      ActivityModel(
        timeId: activityTimeId,
        subjectName: subject.name,
        activity: activity,
        dateTime: dateTime,
      ),
    );

    _updateWithCachedData(subjectTimeId);

    _syncDb()?.addActivity(subjectTimeId, activityTimeId, activity, dateTime);
  }

  void removeActivity(int subjectTimeId, int activityTimeId) {
    var activity = _activitiesCacheDb(subjectTimeId).firstWhere((activity) {
      return activity.timeId == activityTimeId;
    });

    _activitiesCacheDb(subjectTimeId).remove(activity);

    _updateWithCachedData(subjectTimeId);

    _syncDb()?.deleteActivity(subjectTimeId, activityTimeId);
  }

  void editActivity(
    int subjectTimeId,
    int activityTimeId,
    String newActivity,
    DateTime newDateTime,
  ) {
    var oldActivity = _activitiesCacheDb(subjectTimeId).firstWhere((activity) {
      return activity.timeId == activityTimeId;
    });

    oldActivity.activity = newActivity;
    oldActivity.dateTime = newDateTime;

    _updateWithCachedData(subjectTimeId);

    _syncDb()?.editActivity(
      subjectTimeId,
      activityTimeId,
      newActivity,
      newDateTime,
    );
  }

  void _updateWithCachedData(int subjectTimeId) {
    subjectController.data.firstWhere((subject) {
      return subject.timeId == subjectTimeId;
    }).activities = _activitiesCacheDb(subjectTimeId);

    notifyListeners();
  }
}
