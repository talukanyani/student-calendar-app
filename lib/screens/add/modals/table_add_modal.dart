import 'dart:math';
import 'package:flutter/material.dart';

import 'package:sc_app/utils/table_colors.dart';
import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/android_system_navbar.dart';
import '../widgets/label_text.dart';
import '../widgets/radio_color_block.dart';

class TableAddModal extends StatefulWidget {
  const TableAddModal({super.key});

  @override
  State<TableAddModal> createState() => _TableAddModalState();
}

class _TableAddModalState extends State<TableAddModal> {
  String _selectedColor = _colors[Random().nextInt(7)];

  static final List<String> _colors = [...tableColors.keys];

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: CustomColorScheme.grey2,
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        insetPadding: const EdgeInsets.all(16),
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetAnimationCurve: Curves.ease,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Add Subject Table',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            const LabelText(text: 'Title'),
            const TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              maxLength: 30,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
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
                  onPressed: () {},
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
        ),
      ),
    );
  }
}
