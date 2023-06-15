import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import '../../../widgets/subject_picker.dart';

class SubjectInput extends ConsumerWidget {
  const SubjectInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final int? initialInput;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String subjectName(int? id) {
      return (id != null) ? ref.watch(subjectProvider(id)).name : '';
    }

    final inputController = TextEditingController(
      text: subjectName(initialInput),
    );

    return TextField(
      onTap: () => showDialog<int>(
        context: context,
        builder: (context) => const SubjectPicker(
          title: Text('Select a subject/module/course'),
        ),
      ).then((value) {
        if (value == null) return;
        inputController.text = subjectName(value);
        onChanged(value);
      }),
      controller: inputController,
      readOnly: true,
      decoration: const InputDecoration(hintText: 'Select a subject...'),
    );
  }
}
