import 'package:flutter/material.dart';

enum AuthStatus {
  done,
  unknownError,
  networkError,
  emailInUse,
  profileNotFound,
  weakPassword,
  wrongPassword,
}

enum SnackBarIcon {
  none,
  done,
  error,
  info,
}

enum TablesSortSetting {
  name,
  dateAdded,
}

extension TablesSortSettingExtension on TablesSortSetting {
  String get title {
    switch (this) {
      case TablesSortSetting.name:
        return 'Name';
      case TablesSortSetting.dateAdded:
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
