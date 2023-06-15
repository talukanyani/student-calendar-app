import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/widgets/modal.dart';

class CalendarWeekStartSettingModal extends ConsumerWidget {
  const CalendarWeekStartSettingModal({super.key});

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
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(Helpers.getFullWeekDayName(value - 1)),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        option(DateTime.monday),
        option(DateTime.sunday),
        option(DateTime.saturday),
      ],
    );
  }
}
