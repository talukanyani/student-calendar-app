import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ActivityTimeInput extends StatefulWidget {
  const ActivityTimeInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final TimeOfDay? initialInput;
  final void Function(TimeOfDay) onChanged;

  @override
  State<ActivityTimeInput> createState() => _ActivityTimeInputState();
}

class _ActivityTimeInputState extends State<ActivityTimeInput> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    Future(() {
      _textEditingController.text = widget.initialInput?.format(context) ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () => showTimePicker(
        context: context,
        initialTime:
            widget.initialInput ?? const TimeOfDay(hour: 10, minute: 0),
      ).then((pickedTime) {
        if (pickedTime != null) {
          _textEditingController.text = pickedTime.format(context);
          widget.onChanged(pickedTime);
        }
      }),
      controller: _textEditingController,
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
