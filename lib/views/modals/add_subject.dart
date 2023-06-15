import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/controllers/data.dart' show DataAddStatus;
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/shake_animation.dart';
import 'package:sc_app/views/widgets/snackbar.dart';
import 'widgets/modal_form.dart';
import 'widgets/subject_name_input.dart';
import 'widgets/subject_color_picker.dart';

class AddSubjectModal extends ConsumerStatefulWidget {
  const AddSubjectModal({super.key});

  @override
  ConsumerState<AddSubjectModal> createState() => _AddSubjectModalState();
}

class _AddSubjectModalState extends ConsumerState<AddSubjectModal> {
  String? _name;
  String _colorName =
      subjectColorNames[Random().nextInt(subjectColorNames.length)];

  final _shakeKey = GlobalKey<ShakeAnimationState>();

  void _addSubject(BuildContext context) {
    ref
        .read(dataProvider.notifier)
        .addSubject(
          Subject(
            id: DateTime.now().millisecondsSinceEpoch,
            name: _name!,
            colorName: _colorName,
            activities: [],
          ),
        )
        .then((value) {
      Navigator.pop(context);

      if (value == DataAddStatus.limitError) {
        showDialog(
          context: context,
          builder: (context) => const InfoAlert(
            title: Text('Subject Limit Reached'),
            content: Text(
              'You have reached maximum number of subjects. '
              'Go to Tables and delete unused or old subjects.',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackBar(
            context,
            text: '$_name subject was successfully added',
            snackBarIcon: SnackBarIcon.done,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalForm(
      title: 'Add a Subject',
      inputFields: [
        const InputFieldLabel(label: 'Title'),
        ShakeAnimation(
          key: _shakeKey,
          child: SubjectNameInput(
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
      submitButtonText: 'Add',
      onSubmit: () {
        if (_name == null || _name!.isEmpty) {
          _shakeKey.currentState?.shake();
        } else {
          _addSubject(context);
        }
      },
    );
  }
}
