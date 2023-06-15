import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/enums.dart';
import 'auth.dart';

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((ref) {
  return ThemeModeController();
});

final tablesSortProvider =
    StateNotifierProvider<TablesSortController, TablesSort>((ref) {
  return TablesSortController();
});

final weekStartProvider =
    StateNotifierProvider<WeekStartController, int>((ref) {
  return WeekStartController();
});

final dataSyncProvider = StateNotifierProvider<DataSyncController, bool>((ref) {
  return DataSyncController(ref);
});
