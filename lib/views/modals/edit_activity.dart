import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/input_fields/activity_title_autocomplete_input.dart';
import 'package:sc_app/views/widgets/shake_animation.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

import 'widgets/modal_form.dart';

class EditActivityModal extends ConsumerStatefulWidget {
  const EditActivityModal({super.key, required this.activity});

  final Activity activity;

  @override
  ConsumerState<EditActivityModal> createState() => _EditActivityModalState();
}

class _EditActivityModalState extends ConsumerState<EditActivityModal> {
  String? _title;

  final _shakeKey = GlobalKey<ShakeAnimationState>();

  void _editActivity({required void Function() onDone}) {
    ref.read(dataProvider.notifier).editActivity(
          subjectId: widget.activity.subjectId,
          activityId: widget.activity.id,
          newTitle: _title,
        );

    onDone();
  }

  @override
  Widget build(BuildContext context) {
    return ModalForm(
      title: 'Edit ${widget.activity.title} Activity',
      inputFields: [
        const InputFieldLabel(label: 'Enter New Title'),
        ShakeAnimation(
          key: _shakeKey,
          child: ActivityTitleAutocompleteInput(
            onChanged: (value) {
              setState(() => _title = value);
            },
          ),
        ),
      ],
      submitButtonText: 'Save',
      onSubmit: () {
        if (_title == widget.activity.title) {
          Navigator.pop(context);
          return;
        }

        if (_title == null || _title!.isEmpty) {
          _shakeKey.currentState?.shake();
          return;
        }

        _editActivity(
          onDone: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              mySnackBar(
                context,
                text: 'Activity was successfully edited',
                snackBarIcon: SnackBarIcon.done,
              ),
            );
          },
        );
      },
    );
  }
}
