import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActivityTimeInput extends StatelessWidget {
  const ActivityTimeInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final TimeOfDay? initialInput;
  final void Function(TimeOfDay) onChanged;

  TextEditingController _inputController(BuildContext context) {
    return TextEditingController(text: initialInput?.format(context) ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => showTimePicker(
        context: context,
        initialTime: initialInput ?? const TimeOfDay(hour: 10, minute: 0),
      ).then((pickedTime) {
        if (pickedTime != null) {
          _inputController(context).text = pickedTime.format(context);
          onChanged(pickedTime);
        }
      }),
      controller: _inputController(context),
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
    );
  }
}
