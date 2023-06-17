import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/widgets/modal.dart';

class CalendarWeekStartModal extends ConsumerWidget {
  const CalendarWeekStartModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RadioListTile<int> option(int value) {
      return RadioListTile(
        value: value,
        groupValue: ref.watch(weekStartProvider),
        onChanged: (value) {
          ref.read(weekStartProvider.notifier).set(value ?? 1);
          Navigator.pop(context);
        },
        title: Text(Helpers.getFullWeekDayName(value - 1)),
        visualDensity: const VisualDensity(vertical: -3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        Text(
          'Choose a day',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        option(DateTime.monday),
        option(DateTime.sunday),
        option(DateTime.saturday),
      ],
    );
  }
}
