import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActivityDateInput extends StatefulWidget {
  const ActivityDateInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final DateTime? initialInput;
  final void Function(DateTime) onChanged;

  @override
  State<ActivityDateInput> createState() => _ActivityDateInputState();
}

class _ActivityDateInputState extends State<ActivityDateInput> {
  final _textEditingController = TextEditingController();
  final _currentDate = DateTime.now();

  String formatDate(DateTime? date) => date?.toString().substring(0, 10) ?? '';

  @override
  void initState() {
    _textEditingController.text = formatDate(widget.initialInput);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: widget.initialInput ?? _currentDate,
          firstDate: DateTime(_currentDate.year),
          lastDate: DateTime(_currentDate.year + 1, 12, 31),
        ).then((pickedDate) {
          if (pickedDate != null) {
            _textEditingController.text = formatDate(pickedDate);
            widget.onChanged(pickedDate);
          }
        });
      },
      controller: _textEditingController,
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
