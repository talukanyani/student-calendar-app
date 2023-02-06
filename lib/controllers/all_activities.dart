import 'package:flutter/material.dart';
import 'package:sc_app/helpers/same_date.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

class AllActivitiesController extends ChangeNotifier {
  AllActivitiesController(this.subjectController);

  final SubjectController subjectController;

  List<ActivityModel> get allActivities {
    List<ActivityModel> activities = [];

    for (SubjectModel subject in subjectController.subjects) {
      for (ActivityModel activity in subject.activities) {
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

  List<ActivityModel> getDayActivities(DateTime dayDate) {
    var dayActivities = allActivities.where((activity) {
      return isSameDay(activity.dateTime, dayDate);
    });

    return dayActivities.toList();
  }
}
