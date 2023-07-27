import 'package:flutter/material.dart';
import 'package:sc_app/utils/input_formatter.dart';

class SubjectNameInput extends StatefulWidget {
  const SubjectNameInput({
    super.key,
    this.initialInput,
    required this.onChanged,
  });

  final String? initialInput;
  final void Function(String) onChanged;

  @override
  State<SubjectNameInput> createState() => _SubjectNameInputState();
}

class _SubjectNameInputState extends State<SubjectNameInput> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.text = widget.initialInput ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: (value) => widget.onChanged(value.trim()),
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      maxLength: 30,
      inputFormatters: [
        InputFormatter.noSpaceAtStart(),
        InputFormatter.noDoubleSpace(),
      ],
      style: const TextStyle(letterSpacing: 1),
      decoration: const InputDecoration(
        hintText: 'e.g. Physics',
        counterText: '',
      ),
    );
  }
}
