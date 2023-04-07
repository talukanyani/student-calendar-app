import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/utils/enums.dart';

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController() : super(ThemeMode.system) {
    _useCachedValue();
  }

  void set(ThemeMode value) {
    state = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('themeMode', value.index);
    });
  }

  void _useCachedValue() {
    SharedPreferences.getInstance().then((prefs) {
      state = ThemeMode.values[prefs.getInt('themeMode') ?? state.index];
    });
  }
}

class TablesSortController extends StateNotifier<TablesSort> {
  TablesSortController() : super(TablesSort.name) {
    _useCachedValue();
  }

  void set(TablesSort value) {
    state = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('tablesSort', value.index);
    });
  }

  void _useCachedValue() {
    SharedPreferences.getInstance().then((prefs) {
      state = TablesSort.values[prefs.getInt('tablesSort') ?? state.index];
    });
  }
}

class WeekStartController extends StateNotifier<int> {
  WeekStartController() : super(DateTime.monday) {
    _useCachedValue();
  }

  void set(int value) {
    state = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('weekStart', value);
    });
  }

  void _useCachedValue() {
    SharedPreferences.getInstance().then((prefs) {
      state = prefs.getInt('weekStart') ?? state;
    });
  }
}

class DataSyncController extends StateNotifier<bool> {
  DataSyncController(this.ref) : super(false) {
    _useCachedValue();
  }

  final Ref ref;

  void set(bool value, {bool updateData = true}) {
    state = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDataSync', value);
    });

    if (value && updateData) {
      CloudDb().addMultipleData(
        ref.read(dataProvider),
        userId: ref.read(userIdProvider),
      );
    }

    if (!value && updateData) {
      CloudDb().deleteAllData(ref.read(userIdProvider));
    }
  }

  void _useCachedValue() {
    SharedPreferences.getInstance().then((prefs) {
      state = prefs.getBool('isDataSync') ?? state;
    });
  }
}
