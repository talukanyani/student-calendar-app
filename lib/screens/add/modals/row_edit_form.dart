import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/other_helpers.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../widgets/activity_input.dart';
import '../widgets/label_text.dart';

class RowEditForm extends StatefulWidget {
  const RowEditForm({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.activity,
  });

  final int subjectId;
  final String subjectName;
  final ActivityModel activity;

  @override
  State<RowEditForm> createState() => _RowEditFormState();
}

class _RowEditFormState extends State<RowEditForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  static final DateTime currDate = DateTime.now();

  static final _activityInputController = TextEditingController();
  static final _dateInputController = TextEditingController();
  static final _timeInputController = TextEditingController();

  Future<void> editActivity(BuildContext context) async {
    Provider.of<ActivityController>(context, listen: false).editActivity(
      subjectId: widget.subjectId,
      activityId: widget.activity.id,
      newActivity: _activityInputController.text.trim(),
      newDateTime: DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
    );
  }

  DateTime activityDate() => widget.activity.dateTime;

  @override
  void initState() {
    _activityInputController.text = widget.activity.activity;

    _dateInputController.text =
        activityDate().toLocal().toString().split(' ')[0];
    setState(() {
      _selectedDate = activityDate();
    });

    _timeInputController.text =
        '${Helpers.padTwoNums(activityDate().hour)}:${Helpers.padTwoNums(activityDate().minute)}';
    setState(() {
      _selectedTime = TimeOfDay(
        hour: activityDate().hour,
        minute: activityDate().minute,
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    _activityInputController.clear();
    _dateInputController.clear();
    _timeInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'Edit ${widget.subjectName} Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CustomColorScheme.grey4,
              ),
        ),
        const SizedBox(height: 20),
        const LabelText(text: 'Title'),
        ActivityInput(inputController: _activityInputController),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LabelText(text: 'Date'),
                  TextField(
                    onTap: () => showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? currDate,
                      firstDate: DateTime(currDate.year - 1),
                      lastDate: DateTime(currDate.year + 1, 12, 31),
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
                  const LabelText(text: 'Time'),
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
                  if (_activityInputController.text.isEmpty ||
                      _selectedDate == null ||
                      _selectedTime == null) {
                    Show.snackBar(
                      context,
                      text: 'Please fill all the fields.',
                      snackBarIcon: SnackBarIcon.error,
                    );
                    return;
                  }

                  if (widget.activity.activity ==
                          _activityInputController.text &&
                      activityDate() ==
                          DateTime(
                            _selectedDate!.year,
                            _selectedDate!.month,
                            _selectedDate!.day,
                            _selectedTime!.hour,
                            _selectedTime!.minute,
                          )) {
                    Show.snackBar(
                      context,
                      text: 'You did not change anything :)',
                      snackBarIcon: SnackBarIcon.info,
                    );
                    return;
                  }

                  editActivity(context).then((_) {
                    Navigator.pop(context);
                  }).then((_) {
                    Show.snackBar(
                      context,
                      text:
                          'One of ${widget.subjectName} activities was edited.',
                      snackBarIcon: SnackBarIcon.done,
                    );
                  });
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
