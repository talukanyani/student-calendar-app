import 'package:flutter/material.dart';

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
