import 'package:flutter/material.dart';
import 'package:sc_app/utils/enums.dart';

class SettingController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  TablesSortSetting _tablesSort = TablesSortSetting.name;
  int _weekStartDay = DateTime.monday;

  ThemeMode get themeMode => _themeMode;
  TablesSortSetting get tablesSort => _tablesSort;
  int get weekStartDay => _weekStartDay;

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
}
