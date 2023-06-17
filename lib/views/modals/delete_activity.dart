import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/widgets/alerts.dart';

class DeleteActivityModal extends ConsumerWidget {
  const DeleteActivityModal({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String subjectName(int id) => ref.watch(subjectProvider(id)).name;

    return ConfirmationAlert(
      title: const Text('Delete Activity?'),
      content: Text(
        '${subjectName(activity.subjectId)} ${activity.title}'
        ' will be deleted permanently.',
      ),
      actionName: 'Delete',
      action: () => ref.watch(dataProvider.notifier).deleteActivity(
            subjectId: activity.subjectId,
            activityId: activity.id,
          ),
    );
  }
}
