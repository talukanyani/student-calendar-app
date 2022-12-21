import 'package:flutter/material.dart';
import 'package:sc_app/screens/add/widgets/label_and_border.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return LabelAndBorderContainer(
      label: 'Time',
      child: TextField(
        keyboardType: TextInputType.datetime,
        maxLength: 5,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.headline5?.color,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          counterText: '',
          hintText: 'Time',
          hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
