import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TimeInput extends StatefulWidget {
  const TimeInput({super.key});

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  TimeOfDay? selectedTime;
  final TimeOfDay currTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isInputNull = selectedTime == null;

    return TextField(
      onTap: () => _selectDate(context),
      readOnly: true,
      decoration: InputDecoration(
        hintText: isInputNull ? 'Time' : selectedTime!.format(context),
        hintStyle: isInputNull
            ? Theme.of(context).inputDecorationTheme.hintStyle
            : TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        prefixIcon: const Icon(
          Iconsax.clock_1,
          size: 20,
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 32,
        ),
      ),
    );
  }
}
