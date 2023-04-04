import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';
import 'package:sc_app/utils/enums.dart';
import 'authentication.dart';

class SettingController extends ChangeNotifier {
  SettingController(this.authController) {
    _useChachedSettings();
  }

  final AuthController authController;

  bool get _isAuthed => authController.currentUser != null;
  String? get _userId => authController.currentUser?.uid;

  ThemeMode _themeMode = ThemeMode.system;
  TablesSortSetting _tablesSort = TablesSortSetting.name;
  int _weekStartDay = DateTime.monday;
  bool _isActivitiesSync = false;

  ThemeMode get themeMode => _themeMode;
  TablesSortSetting get tablesSort => _tablesSort;
  int get weekStartDay => _weekStartDay;
  bool get isActivitiesSync => _isActivitiesSync && _isAuthed;

  void setTheme(ThemeMode value) {
    _themeMode = value;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('themeMode', value.index);
    });
  }

  void setTablesSort(TablesSortSetting value) {
    _tablesSort = value;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('tablesSort', value.index);
    });
  }

  void setWeekStart(int value) {
    _weekStartDay = value;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('weekStartDay', value);
    });
  }

  Future<void> setActivitiesSync(bool value, {bool updateData = true}) async {
    _isActivitiesSync = value;
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isSync', value);
    });

    if (value && updateData) {
      CloudDb().addMultipleSubjets(
        await LocalDb().cachedSubjects,
        userId: _userId,
      );
    }

    if (!value && updateData) {
      CloudDb().deleteAllSujects(_userId);
    }
  }

  Future<void> _useChachedSettings() async {
    var prefs = await SharedPreferences.getInstance();

    _themeMode =
        ThemeMode.values[prefs.getInt('themeMode') ?? _themeMode.index];
    _tablesSort = TablesSortSetting
        .values[prefs.getInt('tablesSort') ?? _themeMode.index];
    _weekStartDay = prefs.getInt('weekStartDay') ?? _weekStartDay;
    _isActivitiesSync = prefs.getBool('isSync') ?? _isActivitiesSync;

    notifyListeners();
  }
}
