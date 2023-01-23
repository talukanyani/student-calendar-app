import 'package:flutter/material.dart';

import 'package:sc_app/helpers/same_date.dart';

import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/subject_activity.dart';

class AllActivitiesController extends ChangeNotifier {
  AllActivitiesController(this.subjectController);

  final SubjectController subjectController;

  List<SubjectActivityModel> get allActivities {
    List<SubjectActivityModel> activities = [];

    for (SubjectModel subject in subjectController.subjects) {
      for (ActivityModel activity in subject.activities) {
        activities.add(
          SubjectActivityModel(
            subject.name,
            activity.activity,
            activity.dateTime,
          ),
        );
      }
    }

    activities.sort((a, b) => a.date.compareTo(b.date));

    return activities;
  }

  List<SubjectActivityModel> getDayActivities(DateTime dayDate) {
    var dayActivities = allActivities.where((activity) {
      return isSameDay(activity.date, dayDate);
    });

    return dayActivities.toList();
  }
}
