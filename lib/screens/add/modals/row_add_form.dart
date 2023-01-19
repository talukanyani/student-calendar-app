import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/android_system_navbar.dart';
import '../widgets/activity_input.dart';
import '../widgets/label_text.dart';

class RowAddForm extends StatefulWidget {
  const RowAddForm({
    super.key,
    required this.subjectId,
    required this.subjectName,
  });

  final int subjectId;
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

  @override
  void dispose() {
    _activityInputController.clear();
    _dateInputController.clear();
    _timeInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey1,
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        insetPadding: const EdgeInsets.all(16),
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetAnimationCurve: Curves.ease,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
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
                          initialDate: currDate,
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
                          initialTime: const TimeOfDay(hour: 10, minute: 0),
                        ).then((pickedTime) {
                          if (pickedTime != null) {
                            _timeInputController.text =
                                pickedTime.format(context);
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
                OutlinedButton(
                  onPressed: () {
                    if (_activityInputController.text.isEmpty ||
                        _selectedDate == null ||
                        _selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields.'),
                        ),
                      );
                    } else {
                      Provider.of<ActivityController>(context, listen: false)
                          .addActivity(
                        widget.subjectId,
                        _activityInputController.text,
                        DateTime(
                          _selectedDate!.year,
                          _selectedDate!.month,
                          _selectedDate!.day,
                          _selectedTime!.hour,
                          _selectedTime!.minute,
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'One activity was added to ${widget.subjectName}',
                          ),
                        ),
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromWidth(96),
                    side: BorderSide(
                      width: 2,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
