import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';

import 'package:sc_app/utils/table_colors.dart';

import 'package:sc_app/widgets/modal.dart';
import '../widgets/snackbar.dart';
import '../widgets/label_text.dart';
import '../widgets/radio_color_block.dart';

class TableAddForm extends StatefulWidget {
  const TableAddForm({super.key});

  @override
  State<TableAddForm> createState() => _TableAddFormState();
}

class _TableAddFormState extends State<TableAddForm> {
  String _selectedColor = _colors[Random().nextInt(7)];

  static final List<String> _colors = [...tableColors.keys];

  static final _titleInputController = TextEditingController();

  Future<void> addSubject(BuildContext context) async {
    Provider.of<SubjectController>(context, listen: false).addSubject(
      _titleInputController.text,
      _selectedColor,
    );
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
          'Add Subject Table',
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
            TextInputFormatter.withFunction((oldValue, newValue) {
              return newValue.text.startsWith(' ') ? oldValue : newValue;
            }),
            TextInputFormatter.withFunction((oldValue, newValue) {
              return newValue.text.contains('  ') ? oldValue : newValue;
            }),
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
            OutlinedButton(
              onPressed: () {
                if (_titleInputController.text.isEmpty) {
                  showFeedback(context, 'Please enter a title.');
                } else {
                  addSubject(context).then((_) {
                    Navigator.pop(context);
                  }).then((_) {
                    showFeedback(context, 'One subject table was added');
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromWidth(96),
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              child: const Text('Add'),
            ),
          ],
        ),
      ],
    );
  }
}
