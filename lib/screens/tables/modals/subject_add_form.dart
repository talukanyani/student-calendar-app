import 'dart:math';
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

class SubjectAddForm extends ConsumerStatefulWidget {
  const SubjectAddForm({super.key});

  @override
  ConsumerState<SubjectAddForm> createState() => _SubjectAddFormState();
}

class _SubjectAddFormState extends ConsumerState<SubjectAddForm> {
  String _selectedColor =
      subjectColorNames[Random().nextInt(subjectColorNames.length + 1)];

  final _titleInputController = TextEditingController();

  void _addSubject() {
    ref.read(dataProvider.notifier).addSubject(
          Subject(
            id: DateTime.now().millisecondsSinceEpoch,
            name: _titleInputController.text.trim(),
            color: _selectedColor,
            activities: [],
          ),
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
          'Add a Subject',
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
                  } else {
                    _addSubject();
                    Navigator.pop(context);
                    Show.snackBar(
                      context,
                      text: 'One subject was added',
                      snackBarIcon: SnackBarIcon.done,
                    );
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
