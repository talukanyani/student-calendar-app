import 'package:flutter/material.dart';
import 'package:sc_app/helpers/input_formatter.dart';

class ActivityDescriptionInput extends StatelessWidget {
  const ActivityDescriptionInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final String? initialInput;
  final void Function(String) onChanged;

  TextEditingController get _inputController => TextEditingController(
        text: initialInput ?? '',
      );

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _inputController,
      onChanged: (value) => onChanged(value.trim()),
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLength: 100,
      maxLines: 3,
      inputFormatters: [
        InputFormatter.noSpaceAtStart(),
        InputFormatter.noDoubleSpace(),
      ],
      style: const TextStyle(letterSpacing: 0.8, wordSpacing: 1.6),
      decoration: const InputDecoration(hintText: 'Description'),
    );
  }
}
