import 'package:flutter/material.dart';

import '../widgets/activity_input.dart';
import '../widgets/date_picker.dart';
import '../widgets/time_picker.dart';

class RowAddModalSheet extends StatelessWidget {
  const RowAddModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            height: 2,
            width: 96,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          const ActivityInput(),
          const DatePicker(),
          const TimePicker(),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size.fromWidth(360),
              ),
            ),
            child: const Text('Add Activity'),
          ),
        ],
      ),
    );
  }
}
