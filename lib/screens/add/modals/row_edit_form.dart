import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import 'package:sc_app/widgets/textfield_label.dart';
import '../widgets/activity_input.dart';

class RowEditForm extends ConsumerStatefulWidget {
  const RowEditForm({super.key, required this.activity});

  final Activity activity;

  @override
  ConsumerState<RowEditForm> createState() => _RowEditFormState();
}

class _RowEditFormState extends ConsumerState<RowEditForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final _titleInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _timeInputController = TextEditingController();

  String get _titleInput => _titleInputController.text.trim();

  DateTime get _selectedDateAndTime => DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

  void _editActivity() {
    ref.read(dataProvider.notifier).editActivity(
          subjectId: widget.activity.subjectId,
          activityId: widget.activity.id,
          newTitle: _titleInput,
          newDate: _selectedDateAndTime,
        );
  }

  String get _oldActivityTitle => widget.activity.title;

  DateTime get _oldActivityDate => widget.activity.date;

  @override
  void initState() {
    _titleInputController.text = _oldActivityTitle;
    _dateInputController.text =
        _oldActivityDate.toLocal().toString().split(' ')[0];
    _timeInputController.text =
        '${Helpers.padTwoNums(_oldActivityDate.hour)}:${Helpers.padTwoNums(_oldActivityDate.minute)}';

    setState(() => _selectedDate = _oldActivityDate);
    setState(() {
      _selectedTime = TimeOfDay(
        hour: _oldActivityDate.hour,
        minute: _oldActivityDate.minute,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleInputController.clear();
    _dateInputController.clear();
    _timeInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'Edit an Activity for ${widget.activity.subjectName}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: context.grey4,
              ),
        ),
        const SizedBox(height: 20),
        const TextFieldLabel(text: 'Title'),
        ActivityInput(inputController: _titleInputController),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldLabel(text: 'Date'),
                  TextField(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(DateTime.now().year),
                      lastDate: DateTime(DateTime.now().year + 1, 12, 31),
                    ).then((pickedDate) {
                      if (pickedDate != null) {
                        _dateInputController.text =
                            pickedDate.toLocal().toString().split(' ')[0];
                        setState(() => _selectedDate = pickedDate);
                      }
                    }),
                    controller: _dateInputController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Date',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Icon(
                          Iconsax.calendar,
                          size: 20,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 24,
                        minWidth: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextFieldLabel(text: 'Time'),
                  TextField(
                    onTap: () => showTimePicker(
                      context: context,
                      initialTime:
                          _selectedTime ?? const TimeOfDay(hour: 10, minute: 0),
                    ).then((pickedTime) {
                      if (pickedTime != null) {
                        _timeInputController.text = pickedTime.format(context);
                        setState(() => _selectedTime = pickedTime);
                      }
                    }),
                    controller: _timeInputController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Time',
                      prefixIcon: Icon(
                        Iconsax.clock_1,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minHeight: 24,
                        minWidth: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 96,
              child: PrimaryBorderBtn(
                onPressed: () {
                  if (_titleInput.isEmpty ||
                      _selectedDate == null ||
                      _selectedTime == null) {
                    Show.snackBar(
                      context,
                      text: 'Please fill all the fields.',
                      snackBarIcon: SnackBarIcon.error,
                    );
                    return;
                  }

                  if (_titleInput == _oldActivityTitle &&
                      _selectedDateAndTime == _oldActivityDate) {
                    Show.snackBar(
                      context,
                      text: 'You did not change anything :)',
                      snackBarIcon: SnackBarIcon.info,
                    );
                    return;
                  }

                  _editActivity();
                  Navigator.pop(context);
                  Show.snackBar(
                    context,
                    text: 'One of ${widget.activity.subjectName} '
                        'activities was edited.',
                    snackBarIcon: SnackBarIcon.done,
                  );
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
