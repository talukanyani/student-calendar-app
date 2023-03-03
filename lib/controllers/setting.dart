import 'package:flutter/material.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/services/authentication.dart';
import 'package:sc_app/services/database.dart';

class SettingController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  TablesSortSetting _tablesSort = TablesSortSetting.name;
  int _weekStartDay = DateTime.monday;
  bool _isSync = Auth().currentUser != null;

  ThemeMode get themeMode => _themeMode;
  TablesSortSetting get tablesSort => _tablesSort;
  int get weekStartDay => _weekStartDay;
  bool get isSync => _isSync;

  setTheme(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  setTablesSort(TablesSortSetting value) {
    _tablesSort = value;
    notifyListeners();
  }

  setWeekStart(int value) {
    _weekStartDay = value;
    notifyListeners();
  }

  setSync(bool value) {
    if (value) {
      Database().addAll([]);
    } else {
      Database().deleteAll();
    }

    _isSync = value;

    notifyListeners();
  }
}
