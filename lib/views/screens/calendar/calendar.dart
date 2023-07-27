import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/screens/add_activities/add_activities.dart';
import 'package:sc_app/views/screens/calendar/widgets/calendar.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/main_drawer.dart';
import 'package:sc_app/views/widgets/settings_icon_button.dart';
import 'package:sc_app/views/widgets/side_nav_bar.dart';

import 'state/displayed_month_date.dart';
import 'state/is_day_box.dart';
import 'widgets/day_activities.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  String _monthTitle(DateTime date) {
    final currentDate = DateTime.now();
    final monthName = Helpers.getFullMonthName(date.month - 1);
    final year = (date.year == currentDate.year) ? '' : date.year.toString();

    return '$monthName $year';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availWidth = MediaQuery.of(context).size.width;
    final isDrawer = (availWidth >= 600);

    final displayedMonthDate = ref.watch(displayedMonthDateProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isDrawer,
        title: Text(_monthTitle(displayedMonthDate)),
        actions: [
          !isDrawer ? const SettingsIconButton() : const SizedBox(),
        ],
      ),
      body: SideNavBar(
        screenIndex: 2,
        isVisible: isDrawer,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: const Calendar(),
                ),
              ),
            ),
            isDayBox(availWidth)
                ? Expanded(
                    child: Center(
                      child: Container(
                        height: 320,
                        constraints: const BoxConstraints(maxWidth: 400),
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                        ),
                        child: const DayActivities(),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: isDrawer ? null : const BottomNavBar(screenIndex: 2),
      drawer: isDrawer ? const MainDrawer(screenIndex: 2) : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddActivityScreen()),
        ),
        tooltip: 'Add an activity',
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        child: const Icon(FluentIcons.add_24_filled),
      ),
    );
  }
}
