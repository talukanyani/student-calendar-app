import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/modals/delete_activity.dart';
import 'package:sc_app/views/modals/edit_activity.dart';
import 'package:sc_app/views/modals/reschedule_activity.dart';

import 'popup_menu_tile.dart';
import 'snackbar.dart';
import 'subject_picker.dart';

class ActivityPopupMenuButton extends ConsumerWidget {
  const ActivityPopupMenuButton({
    super.key,
    required this.icon,
    required this.activity,
  });

  final Icon icon;
  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String subjectName(int id) => ref.watch(subjectProvider(id)).name;

    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(0),
      icon: icon,
      tooltip: 'more actions',
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: popupMenuTile(
            title: 'Edit',
            icon: FluentIcons.edit_24_regular,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: popupMenuTile(
            title: 'Reschedule',
            icon: FluentIcons.calendar_edit_24_regular,
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: popupMenuTile(
            title: 'Change Subject',
            icon: FluentIcons.arrow_swap_24_regular,
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: popupMenuTile(
            title: 'Delete',
            icon: FluentIcons.delete_24_regular,
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            showDialog(
              context: context,
              builder: (context) => EditActivityModal(activity: activity),
            );
            break;
          case 2:
            showDialog(
              context: context,
              builder: (context) => RescheduleActivityModal(
                activity: activity,
              ),
            );
            break;
          case 3:
            showDialog<int>(
              context: context,
              builder: (context) => const SubjectPicker(
                title: Text('Change to:'),
              ),
            ).then((value) {
              if (value == null) return;
              if (value == activity.subjectId) return;

              ref
                  .watch(dataProvider.notifier)
                  .addActivity(activity.copyWith(subjectId: value))
                  .then((_) {
                ref.watch(dataProvider.notifier).deleteActivity(
                  subjectId: activity.subjectId,
                  activityId: activity.id,
                );
              });

              ScaffoldMessenger.of(context).showSnackBar(
                mySnackBar(
                  context,
                  text: 'Activity was successfully moved to '
                      '${subjectName(value)}',
                  snackBarIcon: SnackBarIcon.done,
                ),
              );
            });
            break;
          case 4:
            showDialog(
              context: context,
              builder: (context) => DeleteActivityModal(activity: activity),
            );
        }
      },
    );
  }
}
