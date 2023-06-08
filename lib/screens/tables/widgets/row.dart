import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import '../modals/activity_edit_form.dart';
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

TableRow row({required Activity activity}) {
  final activityDate = activity.date;

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
      MoreRowActionsButton(activity: activity),
    ],
  );
}

class MoreRowActionsButton extends ConsumerWidget {
  const MoreRowActionsButton({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  modal: ActivityEditForm(activity: activity),
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
                      '${activity.title} activity will be deleted permanently.',
                    ),
                    actionName: 'Delete',
                    action: () {
                      ref.read(dataProvider.notifier).deleteActivity(
                            activityId: activity.id,
                            subjectId: activity.subjectId,
                          );
                      Show.snackBar(
                        context,
                        text: 'One activity from ${activity.subjectName} '
                            'was deleted.',
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
