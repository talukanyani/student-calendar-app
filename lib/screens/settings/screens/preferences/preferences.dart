import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/utils/enums.dart';
import 'settings/calendar_week_start.dart';
import 'settings/tables_sort.dart';
import 'settings/theme_mode.dart';

class PreferencesScreen extends ConsumerWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferences')),
      body: ListView(
        primary: false,
        children: [
          ListTile(
            title: const Text('Theme Mode'),
            subtitle: Text(ref.watch(themeModeProvider).title),
            leading: const Column(
              children: [
                Spacer(),
                Icon(FluentIcons.dark_theme_24_filled),
                Spacer(),
              ],
            ),
            onTap: () => Show.modal(
              context,
              modal: const ThemeModeSettingModal(),
            ),
          ),
          ListTile(
            title: const Text('Sort Tables By'),
            subtitle: Text(ref.watch(tablesSortProvider).title),
            leading: const Column(
              children: [
                Spacer(),
                Icon(FluentIcons.table_settings_24_filled),
                Spacer(),
              ],
            ),
            onTap: () => Show.modal(
              context,
              modal: const TablesSortSettingModal(),
            ),
          ),
          ListTile(
            title: const Text('Calendar Week Start'),
            subtitle: Text(
              getWeekDayFullName(ref.watch(weekStartProvider) - 1),
            ),
            leading: const Column(
              children: [
                Spacer(),
                Icon(FluentIcons.calendar_week_start_24_filled),
                Spacer(),
              ],
            ),
            onTap: () => Show.modal(
              context,
              modal: const CalendarWeekStartSettingModal(),
            ),
          ),
        ],
      ),
    );
  }
}
