import 'package:flutter/material.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/services/authentication.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';

class SettingController extends ChangeNotifier {
  SettingController() {
    _useChachedSettings().then((_) {
      _useSyncedSettings();
    });
  }

  ThemeMode _themeMode = ThemeMode.system;
  TablesSortSetting _tablesSort = TablesSortSetting.name;
  int _weekStartDay = DateTime.monday;
  bool _isSync = Auth().currentUser != null;

  ThemeMode get themeMode => _themeMode;
  TablesSortSetting get tablesSort => _tablesSort;
  int get weekStartDay => _weekStartDay;
  bool get isSync => _isSync;

  void setTheme(ThemeMode value) {
    _themeMode = value;
    notifyListeners();

    _cacheSettings();
  }

  void setTablesSort(TablesSortSetting value) {
    _tablesSort = value;
    notifyListeners();

    _cacheSettings();
    _syncSettings();
  }

  void setWeekStart(int value) {
    _weekStartDay = value;
    notifyListeners();

    _cacheSettings();
    _syncSettings();
  }

  Future<void> setSync(bool value) async {
    _isSync = value;
    notifyListeners();

    _cacheSettings();

    if (value) {
      CloudDatabase().addMultipleSubjets(
        await LocalDatabase().cachedSubjects,
      );
      _syncSettings();
    } else {
      CloudDatabase().deleteAllSujects();
      CloudDatabase().unSyncSettings();
    }
  }

  void _cacheSettings() {
    LocalDatabase().cacheSettings({
      'themeMode': _themeMode.index,
      'tablesSort': _tablesSort.index,
      'weekStartDay': _weekStartDay,
      'isSync': _isSync,
    });
  }

  void _syncSettings() {
    CloudDatabase? sync = _isSync ? CloudDatabase() : null;
    sync?.syncSettings({
      'tablesSort': _tablesSort.index,
      'weekStartDay': _weekStartDay,
      'isSync': true,
    });
  }

  Future<void> _useChachedSettings() async {
    var cachedSettings = await LocalDatabase().cachedSettings;
    if (cachedSettings.isEmpty) return;

    _themeMode = ThemeMode.values[cachedSettings['themeMode']];
    _tablesSort = TablesSortSetting.values[cachedSettings['tablesSort']];
    _weekStartDay = cachedSettings['weekStartDay'];
    _isSync = cachedSettings['isSync'];

    notifyListeners();
  }

  Future<void> _useSyncedSettings() async {
    var syncedSettings = await CloudDatabase().syncedSettings;
    if (syncedSettings.isEmpty) return;

    if (syncedSettings['isSync']) {
      _tablesSort = TablesSortSetting.values[syncedSettings['tablesSort']];
      _weekStartDay = syncedSettings['weekStartDay'];
      _isSync = true;

      notifyListeners();

      LocalDatabase().cacheSettings({
        'themeMode': _themeMode.index,
        'tablesSort': syncedSettings['tablesSort'],
        'weekStartDay': syncedSettings['weekStartDay'],
        'isSync': true,
      });
    }
  }
}
