import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/input_field_label.dart';
import 'package:sc_app/widgets/input_fields/activity_description_input.dart';
import 'package:sc_app/widgets/input_fields/activity_title_autocomplete_input.dart';
import 'package:sc_app/widgets/shake_animation.dart';
import 'widgets/modal_form.dart';

class EditActivityModal extends ConsumerStatefulWidget {
  const EditActivityModal({super.key, required this.activity});

  final Activity activity;

  @override
  ConsumerState<EditActivityModal> createState() => _EditActivityModalState();
}

class _EditActivityModalState extends ConsumerState<EditActivityModal> {
  String? _title;
  String? _description;

  final _shakeKey = GlobalKey<ShakeAnimationState>();

  void _editActivity({required void Function() onDone}) {
    ref.read(dataProvider.notifier).editActivity(
          subjectId: widget.activity.subjectId,
          activityId: widget.activity.id,
          newTitle: _title,
          newDescription: _description,
        );

    onDone();
  }

  @override
  Widget build(BuildContext context) {
    return ModalForm(
      title: 'Edit ${widget.activity.title} Activity',
      inputFields: [
        const InputFieldLabel(label: 'Title'),
        ShakeAnimation(
          key: _shakeKey,
          child: ActivityTitleAutocompleteInput(
            onChanged: (value) {
              setState(() => _title = value);
            },
          ),
        ),
        const SizedBox(height: 16),
        const InputFieldLabel(label: 'Description (optional)'),
        ActivityDescriptionInput(
          initialInput: widget.activity.description,
          onChanged: (value) {
            setState(() => _description = value);
          },
        ),
      ],
      submitButtonText: 'Save',
      onSubmit: () {
        if (_title == widget.activity.title &&
            _description == widget.activity.description) {
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
            Helpers.showSnackBar(
              context,
              text: 'Activity was successfully edited',
              snackBarIcon: SnackBarIcon.done,
            );
          },
        );
      },
    );
  }
}
