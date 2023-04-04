import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import '../modals/row_edit_form.dart';
import 'oval_text_container.dart';
import 'popup_menu_item.dart';

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

TableRow row({required ActivityModel activity}) {
  final activityTime = activity.dateTime;

  String getYear() {
    if (activityTime.year == DateTime.now().year) {
      return '';
    } else {
      return activityTime.year.toString();
    }
  }

  return TableRow(
    children: [
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(activity.activity),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          '${Helpers.padTwoNums(activityTime.day)} '
          '${getMonthName(activityTime.month - 1)} '
          '${getYear()}',
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          '${Helpers.padTwoNums(activityTime.hour)}:'
          '${Helpers.padTwoNums(activityTime.minute)}',
        ),
      ),
      MoreRowActionsButton(activity: activity),
    ],
  );
}

class MoreRowActionsButton extends StatelessWidget {
  const MoreRowActionsButton({super.key, required this.activity});

  final ActivityModel activity;

  @override
  Widget build(BuildContext context) {
    final activityProvider =
        Provider.of<ActivityController>(context, listen: false);

    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 40,
        child: PopupMenuButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(Iconsax.more),
          itemBuilder: (context) => <PopupMenuItem>[
            popupMenuItem(
              itemName: 'Edit',
              itemIcon: Iconsax.edit,
              onTap: () {
                Navigator.pop(context);
                Show.modal(
                  context,
                  modal: RowEditForm(activity: activity),
                );
              },
            ),
            popupMenuItem(
              itemName: 'Delete',
              itemIcon: Iconsax.trash,
              onTap: () {
                Navigator.pop(context);
                Show.modal(
                  context,
                  modal: Alert(
                    title: const Text(
                      'Delete Permanently',
                    ),
                    titleIcon: const Icon(
                      FluentIcons.delete_24_filled,
                    ),
                    content: Text(
                      '${activity.activity} activity will be deleted permanently.',
                    ),
                    actionName: 'Delete',
                    action: () {
                      activityProvider.deleteActivity(
                        activityId: activity.id,
                        subjectId: activity.subjectId,
                      );
                      Show.snackBar(
                        context,
                        text:
                            'One activity from ${activity.subjectName} was deleted.',
                        snackBarIcon: SnackBarIcon.done,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
