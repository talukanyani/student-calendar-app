import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/database.dart';
import 'package:sc_app/utils/enums.dart';
import 'setting.dart';

class SubjectController extends ChangeNotifier {
  SubjectController(this.settingController) {
    _updateData();
  }

  final SettingController settingController;

  List<SubjectModel> data = [];

  List<SubjectModel> get subjects {
    _sortData(by: settingController.tablesSort);
    print('talu - listener Notified');
    return data;
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

  Future<void> _updateData() async {
    final syncedData = await Database().getSyncedData();
    data = syncedData;
    notifyListeners();
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
