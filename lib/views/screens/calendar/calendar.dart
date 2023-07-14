import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/screens/add_activities/add_activities.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/main_drawer.dart';
import 'package:sc_app/views/widgets/profile_icon_button.dart';
import 'package:sc_app/views/widgets/side_nav_bar.dart';
import 'state/displayed_month_date.dart';
import 'widgets/calendar.dart';

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
        actions: const [ProfileIconButton()],
      ),
      body: SideNavBar(
        screenIndex: 2,
        isVisible: isDrawer,
        child: const Calendar(),
      ),
      bottomNavigationBar: isDrawer ? null : const BottomNavBar(screenIndex: 2),
      drawer: isDrawer ? const MainDrawer(screenIndex: 2) : null,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddActivityScreen()),
        ),
        tooltip: 'add an activity',
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        child: const Icon(FluentIcons.add_24_filled),
      ),
    );
  }
}
