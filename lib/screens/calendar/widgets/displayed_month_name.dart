import 'package:flutter/material.dart';
import 'package:sc_app/utils/calendar_names.dart';

class DisplayedMonthName extends StatelessWidget {
  const DisplayedMonthName({super.key, required this.monthDate});

  final DateTime monthDate;

  String getYear() {
    if (monthDate.year == DateTime.now().year) return '';
    return ' ${monthDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        getMonthFullName(monthDate.month - 1) + getYear(),
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
