import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import 'package:sc_app/widgets/textfield_label.dart';
import '../widgets/radio_color_block.dart';

class TableEditForm extends ConsumerStatefulWidget {
  const TableEditForm({super.key, required this.subject});

  final Subject subject;

  @override
  ConsumerState<TableEditForm> createState() => _TableEditFormState();
}

class _TableEditFormState extends ConsumerState<TableEditForm> {
  String _selectedColor = subjectColorNames[0];

  final _titleInputController = TextEditingController();

  void _editSubject() {
    ref.read(dataProvider.notifier).editSubject(
          id: widget.subject.id,
          newName: _titleInputController.text.trim(),
          newColor: _selectedColor,
        );
  }

  @override
  void initState() {
    _titleInputController.text = widget.subject.name;
    setState(() => _selectedColor = widget.subject.color);
    super.initState();
  }

  @override
  void dispose() {
    _titleInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'Edit a Subject',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: context.grey4,
              ),
        ),
        const SizedBox(height: 20),
        const TextFieldLabel(text: 'Title'),
        TextField(
          controller: _titleInputController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            InputFormatter.noSpaceAtStart(),
            InputFormatter.noDoubleSpace(),
          ],
          style: const TextStyle(letterSpacing: 1),
          decoration: const InputDecoration(
            hintText: 'Subject Name',
            counterText: '',
          ),
        ),
        const SizedBox(height: 16),
        const TextFieldLabel(text: 'Color'),
        // color picker
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (constraints.maxWidth ~/ 40),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 7,
              itemBuilder: (context, index) {
                return RadioColorBlock(
                  color: subjectColorNames[index],
                  selectedColor: _selectedColor,
                  onChanged: (color) {
                    setState(() => _selectedColor = color);
                  },
                );
              },
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 96,
              child: PrimaryBorderBtn(
                onPressed: () {
                  if (_titleInputController.text.isEmpty) {
                    Show.snackBar(
                      context,
                      text: 'Please enter a title.',
                      snackBarIcon: SnackBarIcon.error,
                    );
                  } else if (_titleInputController.text ==
                          widget.subject.name &&
                      _selectedColor == widget.subject.color) {
                    Show.snackBar(
                      context,
                      text: 'You did not change anything :)',
                      snackBarIcon: SnackBarIcon.info,
                    );
                  } else {
                    _editSubject();
                    Navigator.pop(context);
                    Show.snackBar(
                      context,
                      text: 'One subject was edited',
                      snackBarIcon: SnackBarIcon.done,
                    );
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
