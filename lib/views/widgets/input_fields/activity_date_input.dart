import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActivityDateInput extends StatelessWidget {
  const ActivityDateInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final DateTime? initialInput;
  final void Function(DateTime) onChanged;

  static final _currentDate = DateTime.now();

  TextEditingController get _inputController => TextEditingController(
        text: initialInput?.toLocal().toString().split(' ').first ?? '',
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: initialInput ?? _currentDate,
          firstDate: DateTime(_currentDate.year),
          lastDate: DateTime(_currentDate.year + 1, 12, 31),
        ).then((pickedDate) {
          if (pickedDate != null) {
            _inputController.text =
                pickedDate.toLocal().toString().split(' ').first;
            onChanged(pickedDate);
          }
        });
      },
      controller: _inputController,
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
    );
  }
}
