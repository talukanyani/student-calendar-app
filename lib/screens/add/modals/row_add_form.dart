import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../widgets/activity_input.dart';
import '../widgets/label_text.dart';

class RowAddForm extends ConsumerStatefulWidget {
  const RowAddForm({super.key, required this.subject});

  final Subject subject;

  @override
  ConsumerState<RowAddForm> createState() => _RowAddFormState();
}

class _RowAddFormState extends ConsumerState<RowAddForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  final _titleInputController = TextEditingController();
  final _dateInputController = TextEditingController();
  final _timeInputController = TextEditingController();

  void _addActivity() {
    ref.read(dataProvider.notifier).addActivity(
          Activity(
            id: DateTime.now().millisecondsSinceEpoch,
            subjectId: widget.subject.id,
            subjectName: widget.subject.name,
            title: _titleInputController.text.trim(),
            date: DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            ),
          ),
        );
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
          'Add an Activity for ${widget.subject.name}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CustomColorScheme.grey4,
              ),
        ),
        const SizedBox(height: 20),
        const LabelText(text: 'Title'),
        ActivityInput(inputController: _titleInputController),
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
                  if (_titleInputController.text.isEmpty ||
                      _selectedDate == null ||
                      _selectedTime == null) {
                    Show.snackBar(
                      context,
                      text: 'Please fill all the fields.',
                      snackBarIcon: SnackBarIcon.error,
                    );
                  } else {
                    _addActivity();
                    Navigator.pop(context);
                    Show.snackBar(
                      context,
                      text: 'One activity for ${widget.subject.name} '
                          'was added',
                      snackBarIcon: SnackBarIcon.done,
                    );
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
