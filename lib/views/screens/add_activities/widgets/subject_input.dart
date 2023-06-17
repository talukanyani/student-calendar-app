import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';

import '../../../widgets/subject_picker.dart';

class SubjectInput extends ConsumerStatefulWidget {
  const SubjectInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final int? initialInput;
  final void Function(int) onChanged;

  @override
  ConsumerState<SubjectInput> createState() => _SubjectInputState();
}

class _SubjectInputState extends ConsumerState<SubjectInput> {
  final _inputController = TextEditingController();

  String subjectName(int? id) {
    return (id != null) ? ref.watch(subjectProvider(id)).name : '';
  }

  @override
  void initState() {
    Future(() {
      _inputController.text = subjectName(widget.initialInput);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => showDialog<int>(
        context: context,
        builder: (context) => const SubjectPicker(
          title: Text('Select a subject'),
        ),
      ).then((value) {
        if (value == null) return;
        _inputController.text = subjectName(value);
        widget.onChanged(value);
      }),
      controller: _inputController,
      readOnly: true,
      decoration: const InputDecoration(hintText: 'Select a subject...'),
    );
  }
}
