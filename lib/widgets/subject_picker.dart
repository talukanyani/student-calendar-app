import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/modals/add_subject.dart';

class SubjectPicker extends ConsumerWidget {
  const SubjectPicker({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Subject> subjects() {
      final subjects = ref.watch(subjectsAndActivitiesProvider);
      subjects.sort((a, b) => a.name.compareTo(b.name));
      return subjects;
    }

    return SimpleDialog(
      title: title,
      children: [
        SimpleDialogOption(
          child: ListTile(
            onTap: () => showDialog(
              context: context,
              builder: (context) => const AddSubjectModal(),
            ),
            title: const Text('New Subject'),
            leading: const Icon(Icons.add),
          ),
        ),
        for (final subject in subjects())
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, subject.id),
            child: ListTile(
              title: Text(subject.name),
              leading: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: 4,
                      color: context.subjectColors[subject.colorName],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
