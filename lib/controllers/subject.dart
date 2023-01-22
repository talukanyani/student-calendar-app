import 'package:flutter/material.dart';

import 'package:sc_app/models/subject.dart';
import 'package:sc_app/data/subject.dart';

class SubjectController extends ChangeNotifier {
  final List<SubjectModel> data = initialData;

  List<SubjectModel> get subjects {
    // sort activities by date old to new
    for (SubjectModel subject in data) {
      subject.activities.sort((a, b) {
        return a.dateTime.compareTo(b.dateTime);
      });
    }
    return data;
  }

  void addSubject(String subjectName, String color) {
    if (data.length >= 20) return;

    data.add(
      SubjectModel(data.length + 1, subjectName, color, []),
    );
    notifyListeners();
  }

  void removeSubject(int subjectId) {
    data.removeWhere((subject) => subject.id == subjectId);
    notifyListeners();
  }

  void editSubject(int subjectId, String newName, String newColor) {
    SubjectModel oldSubject = data.firstWhere(
      (subject) => subject.id == subjectId,
    );

    oldSubject.name = newName;
    oldSubject.color = newColor;

    notifyListeners();
  }
}
