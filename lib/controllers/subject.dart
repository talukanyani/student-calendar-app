import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/database.dart';
import 'package:sc_app/utils/enums.dart';
import 'setting.dart';

class SubjectController extends ChangeNotifier {
  SubjectController(this.settingController) {
    _updateWithCachedData();
    _updateWithSyncedData();
  }

  final SettingController settingController;

  List<SubjectModel> data = [];

  List<SubjectModel> cacheDb = [];

  // if sync setting is off, syncDb() will be null
  // therefore database won't be accesed
  Database? syncDb() => settingController.isSync ? Database() : null;

  List<SubjectModel> get subjects {
    _sortData(by: settingController.tablesSort);
    return data;
  }

  void addSubject(int timeId, String name, String color) {
    if (data.length >= 20) return;

    cacheDb.add(
      SubjectModel(timeId: timeId, name: name, color: color, activities: []),
    );

    _updateWithCachedData();

    syncDb()?.addSubject(timeId, name, color);
  }

  void removeSubject(int timeId) {
    cacheDb.removeWhere((subject) => subject.timeId == timeId);
    _updateWithCachedData();
    syncDb()?.deleteSubject(timeId);
  }

  void editSubject(int timeId, String newName, String newColor) {
    var oldSubject = cacheDb.firstWhere((subject) {
      return subject.timeId == timeId;
    });

    oldSubject.name = newName;
    oldSubject.color = newColor;

    _updateWithCachedData();

    syncDb()?.editSubject(timeId, newName, newColor);
  }

  void _updateWithCachedData() {
    data = cacheDb;
    notifyListeners();
  }

  Future<void> _updateWithSyncedData() async {
    final syncedData = await syncDb()?.getSyncedData();
    if (syncedData != null) {
      data = syncedData;
      notifyListeners();
    }
  }

  void _sortData({required TablesSortSetting by}) {
    switch (by) {
      case TablesSortSetting.name:
        data.sort((a, b) {
          return a.name.compareTo(b.name);
        });
        break;
      default: // case TablesSortSetting.dateAdded:
        data.sort((a, b) {
          return a.timeId.compareTo(b.timeId);
        });
    }
  }
}
