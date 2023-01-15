import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DateInput extends StatefulWidget {
  const DateInput({super.key});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  DateTime? selectedDate;
  final DateTime currDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currDate,
      firstDate: DateTime(currDate.year - 1),
      lastDate: DateTime(currDate.year + 1, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isInputNull = selectedDate == null;

    return TextField(
      onTap: () => _selectDate(context),
      readOnly: true,
      decoration: InputDecoration(
        hintText: isInputNull
            ? 'Date'
            : selectedDate!.toLocal().toString().split(' ')[0],
        hintStyle: isInputNull
            ? Theme.of(context).inputDecorationTheme.hintStyle
            : TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onBackground,
              ),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Icon(
            Iconsax.calendar,
            size: 20,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 24,
          minWidth: 40,
        ),
      ),
    );
  }
}
