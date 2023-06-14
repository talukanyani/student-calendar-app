import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/widgets/alerts.dart';

class DeleteActivityModal extends ConsumerWidget {
  const DeleteActivityModal({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String subjectName(int id) => ref.watch(subjectProvider(id)).name;

    return ConfirmationAlert(
      title: const Text('Delete Activity?'),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${subjectName(activity.subjectId)} ${activity.title}'
                  ' will be',
            ),
            TextSpan(
              text: 'deleted permanently.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
      action: () => ref.watch(dataProvider.notifier).deleteActivity(
            subjectId: activity.subjectId,
            activityId: activity.id,
          ),
    );
  }
}
