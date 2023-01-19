import 'package:flutter/material.dart';

import 'package:sc_app/models/subject.dart';
import 'package:sc_app/data/subject.dart';

class SubjectController extends ChangeNotifier {
  final List<SubjectModel> subjectData = initialData;

  List<SubjectModel> get subjects => subjectData;

  void addSubject(String subjectName, String color) {
    subjectData.add(
      SubjectModel(subjectData.length + 1, subjectName, color, []),
    );
    notifyListeners();
  }
}
