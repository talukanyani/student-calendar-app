import 'package:flutter/material.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/activity_popup_menu.dart';
import 'oval_text_container.dart';

TableRow headerRow() {
  return const TableRow(
    children: [
      OvalTextContainer(
        text: Text('Activity'),
        horizontalPadding: 8,
      ),
      OvalTextContainer(
        text: Text('Date'),
        horizontalPadding: 8,
      ),
      OvalTextContainer(
        text: Text('Time'),
        horizontalPadding: 8,
      ),
      SizedBox(
        height: 24,
        child: Text(''),
      ),
    ],
  );
}

TableRow row({required Activity activity}) {
  final activityDate = activity.dateTime;

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(activity.title),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          '${Helpers.padTwoNums(activityDate.day)} '
          '${getMonthName(activityDate.month - 1)} '
          '${activityDate.year == DateTime.now().year ? '' : activityDate.year}',
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          '${Helpers.padTwoNums(activityDate.hour)}:'
          '${Helpers.padTwoNums(activityDate.minute)}',
        ),
      ),
      Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: 40,
          child: ActivityPopupMenuButton(activity: activity),
        ),
      ),
    ],
  );
}
