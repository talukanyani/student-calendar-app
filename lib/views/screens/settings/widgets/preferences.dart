import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/helpers.dart';

class Preferences extends ConsumerWidget {
  const Preferences({super.key});

  Widget _dropDownButton(
    BuildContext context, {
    required DropdownButton child,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          focusColor: Colors.transparent,
        ),
        child: DropdownButtonHideUnderline(child: child),
      ),
    );
  }

  DropdownMenuItem<ThemeMode> _themeDropDownItem(ThemeMode value) {
    return DropdownMenuItem<ThemeMode>(
      value: value,
      child: Text(value.title),
    );
  }

  DropdownMenuItem<TablesSort> _tablesSortDropDownItem(TablesSort value) {
    return DropdownMenuItem<TablesSort>(
      value: value,
      child: Text(value.title),
    );
  }

  DropdownMenuItem<int> _weekStartDropDownItem(int value) {
    return DropdownMenuItem<int>(
      value: value,
      child: Text(Helpers.getFullWeekDayName(value - 1)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = (availWidth < 360);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Theme Mode'),
          leading: isSmallScreen
              ? null
              : const Icon(FluentIcons.dark_theme_24_filled),
          trailing: _dropDownButton(
            context,
            child: DropdownButton(
              value: ref.watch(themeModeProvider),
              onChanged: (value) => ref.read(themeModeProvider.notifier).set(
                    value ?? ThemeMode.system,
                  ),
              items: [
                _themeDropDownItem(ThemeMode.light),
                _themeDropDownItem(ThemeMode.dark),
                _themeDropDownItem(ThemeMode.system),
              ],
              isDense: true,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        ListTile(
          title: const Text('Sort Tables By'),
          leading: isSmallScreen
              ? null
              : const Icon(FluentIcons.table_settings_24_filled),
          trailing: _dropDownButton(
            context,
            child: DropdownButton(
              value: ref.watch(tablesSortProvider),
              onChanged: (value) => ref.read(tablesSortProvider.notifier).set(
                    value ?? TablesSort.name,
                  ),
              items: [
                _tablesSortDropDownItem(TablesSort.name),
                _tablesSortDropDownItem(TablesSort.dateAdded),
              ],
              isDense: true,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        ListTile(
          title: const Text('Calendar Week Start'),
          leading: isSmallScreen
              ? null
              : const Icon(FluentIcons.calendar_week_start_24_filled),
          trailing: _dropDownButton(
            context,
            child: DropdownButton(
              value: ref.watch(weekStartProvider),
              onChanged: (value) => ref.read(weekStartProvider.notifier).set(
                    value ?? DateTime.monday,
                  ),
              items: [
                _weekStartDropDownItem(DateTime.monday),
                _weekStartDropDownItem(DateTime.sunday),
                _weekStartDropDownItem(DateTime.saturday),
              ],
              isDense: true,
              elevation: 4,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
