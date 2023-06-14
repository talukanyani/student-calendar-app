import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';

class ModalForm extends StatelessWidget {
  const ModalForm({
    super.key,
    required this.title,
    required this.inputFields,
    required this.submitButtonText,
    required this.onSubmit,
  });

  final String title;
  final List<Widget> inputFields;
  final String submitButtonText;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: context.grey4,
              ),
        ),
        const SizedBox(height: 20),
        ...inputFields,
        const SizedBox(height: 24),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 16),
            PrimaryFilledBtn(
              onPressed: onSubmit,
              child: Text(submitButtonText),
            ),
          ],
        ),
      ],
    );
  }
}
