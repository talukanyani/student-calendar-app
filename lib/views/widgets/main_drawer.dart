import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:sc_app/views/screens/calendar/calendar.dart';
import 'package:sc_app/views/screens/settings/settings.dart';
import 'package:sc_app/views/screens/tables/tables.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.screenIndex});

  final int screenIndex;

  void pushPrimaryScreen(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 240,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: SingleChildScrollView(
        primary: false,
        child: Container(
          height: MediaQuery.of(context).size.height,
          constraints: const BoxConstraints(minHeight: 320),
          child: Column(
            children: [
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Student Calendar'),
                titleTextStyle: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              ListTile(
                title: const Text('Home'),
                leading: (screenIndex == 0)
                    ? const Icon(FluentIcons.home_24_filled)
                    : const Icon(FluentIcons.home_24_regular),
                selected: (screenIndex == 0),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
              ListTile(
                title: const Text('Tables'),
                leading: (screenIndex == 1)
                    ? const Icon(FluentIcons.table_24_filled)
                    : const Icon(FluentIcons.table_24_regular),
                selected: (screenIndex == 1),
                onTap: () => pushPrimaryScreen(context, const TablesScreen()),
              ),
              ListTile(
                title: const Text('Calendar'),
                leading: (screenIndex == 2)
                    ? const Icon(FluentIcons.calendar_ltr_24_filled)
                    : const Icon(FluentIcons.calendar_ltr_24_regular),
                selected: (screenIndex == 2),
                onTap: () => pushPrimaryScreen(context, const CalendarScreen()),
              ),
              const SizedBox(height: 32),
              const Spacer(),
              ListTile(
                title: const Text('Settings'),
                leading: const Icon(FluentIcons.settings_24_regular),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
