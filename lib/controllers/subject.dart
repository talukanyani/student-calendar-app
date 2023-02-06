import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/database.dart';

class SubjectController extends ChangeNotifier {
  SubjectController() {
    updateData();
  }

  List<SubjectModel> data = [];
  List<SubjectModel> get subjects {
    data.sort((a, b) {
      return a.timeId.compareTo(b.timeId);
    });

    for (SubjectModel subject in data) {
      subject.activities.sort((a, b) {
        return a.dateTime.compareTo(b.dateTime);
      });
    }

    return data;
  }

  Future<void> updateData() async {
    final syncedData = await Database().getSyncedData();
    data = syncedData;
    notifyListeners();
  }

  void addSubject(int timeId, String name, String color) {
    if (data.length >= 20) return;

    data.add(
      SubjectModel(timeId: timeId, name: name, color: color, activities: []),
    );

    notifyListeners();

    Database().addSubject(timeId, name, color);
  }

  void removeSubject(int timeId) {
    data.removeWhere((subject) => subject.timeId == timeId);
    notifyListeners();
    Database().deleteSubject(timeId);
  }

  void editSubject(int timeId, String newName, String newColor) {
    SubjectModel oldSubject = data.firstWhere((subject) {
      return subject.timeId == timeId;
    });

    oldSubject.name = newName;
    oldSubject.color = newColor;

    notifyListeners();

    Database().editSubject(timeId, newName, newColor);
  }
}
