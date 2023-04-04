import 'package:flutter/material.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';

class ActivityController extends ChangeNotifier {
  ActivityController(this.subjectController);

  final SubjectController subjectController;

  List<SubjectModel> get _displayedSubjects {
    return subjectController.displayedSubjects;
  }

  bool get _isSync => subjectController.settingController.isActivitiesSync;
  String? get _userId {
    var authController = subjectController.settingController.authController;
    return authController.currentUser?.uid;
  }

  List<ActivityModel> _displayedActivities(int subjectId) {
    return _displayedSubjects.firstWhere((subject) {
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

    for (var subject in _displayedSubjects) {
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
    if (_displayedActivities(activity.subjectId).length >= 100) return;

    _displayedActivities(activity.subjectId).add(activity);
    notifyListeners();

    LocalDb().cacheSubjects(_displayedSubjects);
    if (_isSync) CloudDb().addActivity(activity, userId: _userId);
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

    LocalDb().cacheSubjects(_displayedSubjects);
    if (_isSync) {
      CloudDb().editActivity(
        userId: _userId,
        subjectId: subjectId,
        activityId: activityId,
        newActivity: newActivity,
        newDate: newDateTime,
      );
    }
  }

  void deleteActivity({required int activityId, required int subjectId}) {
    _displayedActivities(subjectId).removeWhere((activity) {
      return activity.id == activityId;
    });
    notifyListeners();

    LocalDb().cacheSubjects(_displayedSubjects);
    if (_isSync) {
      CloudDb().deleteActivity(
        userId: _userId,
        activityId: activityId,
        subjectId: subjectId,
      );
    }
  }
}
