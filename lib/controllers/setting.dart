import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/auth.dart';
import '../providers/data.dart';
import '../services/cloud_database.dart';

extension ThemeModeExtensiom on ThemeMode {
  String get title {
    switch (this) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System default';
    }
  }
}

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

enum TablesSort {
  name,
  dateAdded,
}

extension TablesSortExtension on TablesSort {
  String get title {
    switch (this) {
      case TablesSort.name:
        return 'Name';
      case TablesSort.dateAdded:
        return 'Date Added';
    }
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

  String? get _userId => ref.read(userProvider)?.uid;

  void set(bool value, {bool updateData = true}) {
    state = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDataSync', value);
    });

    if (value && updateData) {
      CloudDb().addMultipleData(
        ref.read(dataProvider),
        userId: _userId,
      );
    }

    if (!value && updateData) {
      CloudDb().deleteAllData(_userId);
    }
  }

  void _useCachedValue() {
    SharedPreferences.getInstance().then((prefs) {
      state = prefs.getBool('isDataSync') ?? state;
    });
  }
}
