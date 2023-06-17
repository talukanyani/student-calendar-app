import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/shake_animation.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

import 'widgets/modal_form.dart';
import 'widgets/subject_color_picker.dart';
import 'widgets/subject_name_input.dart';

class EditSubjectModal extends ConsumerStatefulWidget {
  const EditSubjectModal({super.key, required this.subject});

  final Subject subject;

  @override
  ConsumerState<EditSubjectModal> createState() => _EditSubjectModalState();
}

class _EditSubjectModalState extends ConsumerState<EditSubjectModal> {
  String? _name;
  String _colorName = subjectColorNames.first;

  final _shakeKey = GlobalKey<ShakeAnimationState>();

  void _editSubjectName({required void Function() onDone}) {
    ref.read(dataProvider.notifier).editSubject(
          id: widget.subject.id,
          newName: _name!,
          newColorName: _colorName,
        );

    onDone();
  }

  @override
  void initState() {
    setState(() => _name = widget.subject.name);
    setState(() => _colorName = widget.subject.colorName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalForm(
      title: 'Edit a Subject',
      inputFields: [
        const InputFieldLabel(label: 'Name'),
        ShakeAnimation(
          key: _shakeKey,
          child: SubjectNameInput(
            initialInput: widget.subject.name,
            onChanged: (value) {
              setState(() => _name = value);
            },
          ),
        ),
        const SizedBox(height: 16),
        const InputFieldLabel(label: 'Colour'),
        SubjectColorPicker(
          pickedColorName: _colorName,
          onChanged: (value) {
            setState(() => _colorName = value);
          },
        ),
      ],
      submitButtonText: 'Save',
      onSubmit: () {
        if (_name == widget.subject.name &&
            _colorName == widget.subject.colorName) {
          Navigator.pop(context);
          return;
        }

        if (_name == null || _name!.isEmpty) {
          _shakeKey.currentState?.shake();
          return;
        }

        _editSubjectName(
          onDone: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              mySnackBar(
                context,
                text: 'Subject was successfully edited',
                snackBarIcon: SnackBarIcon.done,
              ),
            );
          },
        );
      },
    );
  }
}
