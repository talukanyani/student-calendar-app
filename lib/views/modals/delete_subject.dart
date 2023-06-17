import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/widgets/alerts.dart';

class DeleteSubjectModal extends ConsumerWidget {
  const DeleteSubjectModal({super.key, required this.subject});

  final Subject subject;

  String get text {
    final activitiesCount = subject.activities.length;
    String text = '';

    switch (activitiesCount) {
      case 0:
        break;
      case 1:
        text = 'and its activity ';
        break;
      default:
        text = 'and its $activitiesCount activities ';
    }

    return text;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ConfirmationAlert(
      title: const Text('Delete Subject?'),
      content: Text('${subject.name} ${text}will be deleted permanently.'),
      actionName: 'Delete',
      action: () => ref.watch(dataProvider.notifier).deleteSubject(subject.id),
    );
  }
}
