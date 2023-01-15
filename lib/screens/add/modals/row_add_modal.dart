import 'package:flutter/material.dart';

import 'package:sc_app/themes/color_scheme.dart';

import 'package:sc_app/widgets/android_system_navbar.dart';
import '../widgets/activity_input.dart';
import '../widgets/date_input.dart';
import '../widgets/time_input.dart';
import '../widgets/label_text.dart';

class RowAddModal extends StatelessWidget {
  const RowAddModal({super.key, required this.subjectName});

  final String subjectName;

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
              'Add $subjectName Activity',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            const LabelText(text: 'Title'),
            const ActivityInput(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LabelText(text: 'Date'),
                      DateInput(),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      LabelText(text: 'Time'),
                      TimeInput(),
                    ],
                  ),
                ),
              ],
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
