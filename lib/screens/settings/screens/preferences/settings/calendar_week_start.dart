import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/modal.dart';

class CalendarWeekStartSettingModal extends StatelessWidget {
  const CalendarWeekStartSettingModal({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    RadioListTile option(int value) {
      return RadioListTile(
        value: value,
        groupValue: settingController.weekStartDay,
        onChanged: (value) => settingController.setWeekStart(value),
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(getWeekDayFullName(value - 1)),
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
