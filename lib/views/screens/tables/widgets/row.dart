import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/widgets/activity_popup_menu.dart';

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
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          '${Helpers.padTwoNums(activityDate.day)} '
          '${Helpers.getShortMonthName(activityDate.month - 1)} '
          '${activityDate.year == DateTime.now().year ? '' : activityDate.year}',
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          '${Helpers.padTwoNums(activityDate.hour)}:'
          '${Helpers.padTwoNums(activityDate.minute)}',
        ),
      ),
      Material(
        type: MaterialType.transparency,
        child: SizedBox(
          height: 40,
          child: ActivityPopupMenuButton(
            activity: activity,
            icon: const Icon(Iconsax.more),
          ),
        ),
      ),
    ],
  );
}
