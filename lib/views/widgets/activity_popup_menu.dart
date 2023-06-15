import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/views/modals/delete_activity.dart';
import 'package:sc_app/views/modals/edit_activity.dart';
import 'package:sc_app/views/modals/reschedule_activity.dart';
import 'snackbar.dart';
import 'subject_picker.dart';
import 'modal.dart';
import 'popup_menu_tile.dart';

class ActivityPopupMenuButton extends ConsumerWidget {
  const ActivityPopupMenuButton({
    super.key,
    this.icon = const Icon(Iconsax.more),
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
            title: 'View description',
            icon: Iconsax.edit,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: popupMenuTile(
            title: 'Edit',
            icon: Iconsax.edit,
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: popupMenuTile(
            title: 'Reschedule',
            icon: Iconsax.edit,
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: popupMenuTile(
            title: 'Change Subject',
            icon: Iconsax.edit,
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: popupMenuTile(
            title: 'Delete',
            icon: Iconsax.trash,
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            if (activity.description != null) {
              showDialog(
                context: context,
                builder: (context) => Modal(
                  children: [Text(activity.description!)],
                ),
              );
            }
            break;
          case 2:
            showDialog(
              context: context,
              builder: (context) => EditActivityModal(activity: activity),
            );
            break;
          case 3:
            showDialog(
              context: context,
              builder: (context) => RescheduleActivityModal(
                activity: activity,
              ),
            );
            break;
          case 4:
            showDialog<int>(
              context: context,
              builder: (context) => const SubjectPicker(
                title: Text('Change to:'),
              ),
            ).then((value) {
              if (value == null) return;

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
          case 5:
            showDialog(
              context: context,
              builder: (context) => DeleteActivityModal(activity: activity),
            );
        }
      },
    );
  }
}
