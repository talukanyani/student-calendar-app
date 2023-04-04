import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';
import 'package:sc_app/utils/enums.dart';
import 'setting.dart';

class SubjectController extends ChangeNotifier {
  SubjectController(this.settingController) {
    _displayCachedSubjects().then((_) {
      displaySyncedSubjects();
    });
  }

  final SettingController settingController;

  bool get _isSync => settingController.isActivitiesSync;
  String? get _userId => settingController.authController.currentUser?.uid;

  List<SubjectModel> displayedSubjects = [];

  List<SubjectModel> get subjects {
    _sortSubjects();
    return displayedSubjects;
  }

  void addSubject(SubjectModel subject) {
    if (displayedSubjects.length >= 20) return;

    displayedSubjects.add(subject);
    notifyListeners();

    LocalDb().cacheSubjects(displayedSubjects);
    if (_isSync) CloudDb().addSubject(subject, userId: _userId);
  }

  void editSubject(
      {required int id, required String newName, required String newColor}) {
    var oldSubject = displayedSubjects.firstWhere((subject) {
      return subject.id == id;
    });

    oldSubject.name = newName;
    oldSubject.color = newColor;
    notifyListeners();

    LocalDb().cacheSubjects(displayedSubjects);
    if (_isSync) {
      CloudDb().editSubject(
        userId: _userId,
        subjectId: id,
        newName: newName,
        newColor: newColor,
      );
    }
  }

  void deleteSubject(int id) {
    displayedSubjects.removeWhere((subject) => subject.id == id);
    notifyListeners();

    LocalDb().cacheSubjects(displayedSubjects);
    if (_isSync) CloudDb().deleteSubject(id, userId: _userId);
  }

  Future<void> _displayCachedSubjects() async {
    var cachedSubjects = await LocalDb().cachedSubjects;
    displayedSubjects = cachedSubjects;
    notifyListeners();
  }

  Future<void> displaySyncedSubjects() async {
    if (!_isSync) return;

    var syncedSubjects = await CloudDb().getSyncedSubjects(_userId);

    if (syncedSubjects.isEmpty) {
      CloudDb().addMultipleSubjets(displayedSubjects, userId: _userId);
      return;
    }

    displayedSubjects = syncedSubjects;
    notifyListeners();

    LocalDb().cacheSubjects(syncedSubjects);
  }

  void _sortSubjects() {
    switch (settingController.tablesSort) {
      case TablesSortSetting.name:
        displayedSubjects.sort((a, b) {
          return a.name.compareTo(b.name);
        });
        break;
      default: // case TablesSortSetting.dateAdded:
        displayedSubjects.sort((a, b) {
          return a.id.compareTo(b.id);
        });
    }
  }
}
