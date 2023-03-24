import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.subjectController);

  final SubjectController subjectController;

  LocalDatabase _cache() => LocalDatabase();
  CloudDatabase? _sync() =>
      subjectController.settingController.isSync ? CloudDatabase() : null;

  List<ActivityModel> _displayedActivities(int subjectId) {
    return subjectController.displayedSubjets.firstWhere((subject) {
      return subject.id == subjectId;
    }).activities;
  }

  List<ActivityModel> subjectActivities(int subjectId) {
    var activities = _displayedActivities(subjectId);
    activities.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return activities;
  }

  List<ActivityModel> get allActivities {
    List<ActivityModel> activities = [];

    for (var subject in subjectController.displayedSubjets) {
      for (var activity in subject.activities) {
        activities.add(activity);
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

  void addActivity(ActivityModel activity) {
    if (_displayedActivities(activity.subjectId).length >= 50) return;

    _displayedActivities(activity.subjectId).add(activity);

    notifyListeners();

    _cache().cacheSubjects(subjectController.displayedSubjets);
    _sync()?.addActivity(
      activity.subjectId,
      activity.id,
      activity.activity,
      activity.dateTime,
    );
  }

  void removeActivity({required int subjectId, required int activityId}) {
    var activity = _displayedActivities(subjectId).firstWhere((activity) {
      return activity.id == activityId;
    });

    _displayedActivities(subjectId).remove(activity);

    _cache().cacheSubjects(subjectController.displayedSubjets);
    _sync()?.deleteActivity(subjectId, activityId);
  }

  void editActivity({
    required int subjectId,
    required int activityId,
    required String newActivity,
    required DateTime newDateTime,
  }) {
    var oldActivity = _displayedActivities(subjectId).firstWhere((activity) {
      return activity.id == activityId;
    });

    oldActivity.activity = newActivity;
    oldActivity.dateTime = newDateTime;
    notifyListeners();

    _cache().cacheSubjects(subjectController.displayedSubjets);
    _sync()?.editActivity(
      subjectId,
      activityId,
      newActivity,
      newDateTime,
    );
  }
}
