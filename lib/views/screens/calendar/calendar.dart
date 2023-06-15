import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/screens/add_activities/add_activities.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/profile_icon_button.dart';
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
    final displayedMonthDate = ref.watch(displayedMonthDateProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_monthTitle(displayedMonthDate)),
        actions: const [ProfileIconButton()],
      ),
      body: const Calendar(),
      bottomNavigationBar: const BottomNavBar(screenIndex: 2),
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
