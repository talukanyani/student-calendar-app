import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject_activities.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../widgets/snackbar.dart';
import '../widgets/activity_input.dart';
import '../widgets/label_text.dart';

class RowAddForm extends StatefulWidget {
  const RowAddForm({
    super.key,
    required this.subjectTimeId,
    required this.subjectName,
  });

  final int subjectTimeId;
  final String subjectName;

  @override
  State<RowAddForm> createState() => _RowAddFormState();
}

class _RowAddFormState extends State<RowAddForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  static final DateTime currDate = DateTime.now();

  static final _activityInputController = TextEditingController();
  static final _dateInputController = TextEditingController();
  static final _timeInputController = TextEditingController();

  Future<void> addActivity(BuildContext context) async {
    Provider.of<SubjectActivitiesController>(context, listen: false)
        .addActivity(
      widget.subjectTimeId,
      DateTime.now().millisecondsSinceEpoch,
      _activityInputController.text,
      DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      ),
    );
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
          'Add ${widget.subjectName} Activity',
          style: Theme.of(context).textTheme.headline6,
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
                    showFeedback(context, 'Please fill all the fields.');
                  } else {
                    addActivity(context).then((_) {
                      Navigator.pop(context);
                    }).then((_) {
                      showFeedback(context,
                          'One activity was added to ${widget.subjectName}');
                    });
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
