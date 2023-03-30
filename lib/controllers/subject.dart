import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';
import 'package:sc_app/utils/enums.dart';
import 'setting.dart';

class SubjectController extends ChangeNotifier {
  SubjectController(this.settingController) {
    _displayCachedSubjects().then((_) {
      _displaySyncedSubjects();
    });
  }

  final SettingController settingController;
  bool get _isSync => settingController.isSync;

  List<SubjectModel> displayedSubjets = [];

  List<SubjectModel> get subjects {
    _sortSubjects(by: settingController.tablesSort);
    return displayedSubjets;
  }

  void addSubject(int id, String name, String color) {
    if (displayedSubjets.length >= 20) return;

    displayedSubjets.add(
      SubjectModel(id: id, name: name, color: color, activities: []),
    );

    notifyListeners();

    LocalDatabase().cacheSubjects(displayedSubjets);
    if (_isSync) CloudDatabase().addSubject(id, name, color);
  }

  void removeSubject(int id) {
    displayedSubjets.removeWhere((subject) => subject.id == id);
    notifyListeners();

    LocalDatabase().cacheSubjects(displayedSubjets);
    if (_isSync) CloudDatabase().deleteSubject(id);
  }

  void editSubject(int id, String newName, String newColor) {
    var oldSubject = displayedSubjets.firstWhere((subject) => subject.id == id);

    oldSubject.name = newName;
    oldSubject.color = newColor;
    notifyListeners();

    LocalDatabase().cacheSubjects(displayedSubjets);
    if (_isSync) {
      CloudDatabase().editSubject(id, newName, newColor);
    }
  }

  Future<void> _displayCachedSubjects() async {
    var cachedSubjects = await LocalDatabase().cachedSubjects;
    displayedSubjets = cachedSubjects;
    notifyListeners();
  }

  Future<void> _displaySyncedSubjects() async {
    if (!_isSync) return;

    var syncedSubjects = await CloudDatabase().syncedSubjects;

    if (syncedSubjects.isEmpty) {
      CloudDatabase().addMultipleSubjets(displayedSubjets);
      return;
    }

    displayedSubjets = syncedSubjects;
    notifyListeners();

    LocalDatabase().cacheSubjects(syncedSubjects);
  }

  void _sortSubjects({required TablesSortSetting by}) {
    switch (by) {
      case TablesSortSetting.name:
        displayedSubjets.sort((a, b) {
          return a.name.compareTo(b.name);
        });
        break;
      default: // case TablesSortSetting.dateAdded:
        displayedSubjets.sort((a, b) {
          return a.id.compareTo(b.id);
        });
    }
  }
}
