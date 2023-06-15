import 'package:flutter/material.dart';
import 'package:sc_app/utils/input_formatter.dart';

class SubjectNameInput extends StatelessWidget {
  const SubjectNameInput({
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
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      inputFormatters: [
        InputFormatter.noSpaceAtStart(),
        InputFormatter.noDoubleSpace(),
      ],
      style: const TextStyle(letterSpacing: 1),
      decoration: const InputDecoration(
        hintText: 'Subject/Module/Course Name',
        counterText: '',
      ),
    );
  }
}
