import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/helpers.dart';

import '../modals/calendar_week_start.dart';
import '../modals/tables_sort.dart';
import '../modals/theme_mode.dart';

class Preferences extends ConsumerWidget {
  const Preferences({super.key});

  _centeredLeading(Icon icon) {
    return Column(children: [const Spacer(), icon, const Spacer()]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Theme Mode'),
          subtitle: Text(ref.watch(themeModeProvider).title),
          leading: _centeredLeading(
            const Icon(FluentIcons.dark_theme_24_filled),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => const ThemeModeModal(),
          ),
        ),
        ListTile(
          title: const Text('Sort Tables By'),
          subtitle: Text(ref.watch(tablesSortProvider).title),
          leading: _centeredLeading(
            const Icon(FluentIcons.table_settings_24_filled),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => const TablesSortModal(),
          ),
        ),
        ListTile(
          title: const Text('Calendar Week Start'),
          subtitle: Text(
            Helpers.getFullWeekDayName(ref.watch(weekStartProvider) - 1),
          ),
          leading: _centeredLeading(
            const Icon(FluentIcons.calendar_week_start_24_filled),
          ),
          onTap: () => showDialog(
            context: context,
            builder: (context) => const CalendarWeekStartModal(),
          ),
        ),
      ],
    );
  }
}
