import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/utils/table_colors.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';
import '../widgets/label_text.dart';
import '../widgets/radio_color_block.dart';

class TableEditForm extends StatefulWidget {
  const TableEditForm({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.subjectColor,
  });

  final int subjectId;
  final String subjectName;
  final String subjectColor;

  @override
  State<TableEditForm> createState() => _TableEditFormState();
}

class _TableEditFormState extends State<TableEditForm> {
  String _selectedColor = _colors[0];

  static final List<String> _colors = [...tableColors.keys];

  final _titleInputController = TextEditingController();

  void _editSubject(BuildContext context) {
    Provider.of<SubjectController>(context, listen: false).editSubject(
      widget.subjectId,
      _titleInputController.text.trim(),
      _selectedColor,
    );
  }

  @override
  void initState() {
    _titleInputController.text = widget.subjectName;
    setState(() => _selectedColor = widget.subjectColor);
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
          'Edit Subject Table',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        const LabelText(text: 'Title'),
        TextField(
          controller: _titleInputController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.words,
          maxLength: 30,
          inputFormatters: [
            InputFormatter.noSpaceAtStart(),
            InputFormatter.noDoubleSpace(),
          ],
          style: const TextStyle(fontSize: 20),
          decoration: const InputDecoration(
            hintText: 'Subject Name',
            counterText: '',
          ),
        ),
        const SizedBox(height: 16),
        const LabelText(text: 'Color'),
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
                  color: _colors[index],
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
                  } else if (_titleInputController.text == widget.subjectName &&
                      _selectedColor == widget.subjectColor) {
                    Show.snackBar(
                      context,
                      text: 'You did not change anything :)',
                      snackBarIcon: SnackBarIcon.info,
                    );
                  } else {
                    _editSubject(context);
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
