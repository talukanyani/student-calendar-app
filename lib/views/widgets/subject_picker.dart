import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/modals/add_subject.dart';
import 'package:sc_app/views/themes/color_scheme.dart';

class SubjectPicker extends ConsumerWidget {
  const SubjectPicker({super.key, required this.title});

  final Widget title;

  Widget _tile({required Text text, required Icon icon}) {
    return ListTile(
      title: text,
      leading: icon,
      visualDensity: const VisualDensity(
        vertical: -2,
        horizontal: -4,
      ),
      horizontalTitleGap: 16,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Subject> subjects() {
      final subjects = ref.watch(subjectsAndActivitiesProvider);
      subjects.sort((a, b) => a.name.compareTo(b.name));
      return subjects;
    }

    return SizedBox(
      width: 240,
      child: SimpleDialog(
        title: title,
        insetPadding: const EdgeInsets.all(32),
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          SimpleDialogOption(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const AddSubjectModal(),
            ),
            padding: EdgeInsets.zero,
            child: _tile(
              text: const Text('New Subject'),
              icon: const Icon(Iconsax.add_circle),
            ),
          ),
          for (final subject in subjects())
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, subject.id),
              padding: EdgeInsets.zero,
              child: _tile(
                text: Text(subject.name),
                icon: Icon(
                  Icons.circle_rounded,
                  color: context.subjectColors[subject.colorName],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
