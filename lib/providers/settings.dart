import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/setting.dart';

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
