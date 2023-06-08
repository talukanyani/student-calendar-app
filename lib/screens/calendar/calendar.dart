import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/bottom_nav_bar.dart';
import 'package:sc_app/widgets/profile_icon_button.dart';
import 'state/displayed_month_date.dart';
import 'widgets/calendar.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  String _monthTitle(DateTime date) {
    final currentDate = DateTime.now();
    final monthName = getMonthFullName(date.month - 1);
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
    );
  }
}
