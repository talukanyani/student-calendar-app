import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';

class InputFieldLabel extends StatelessWidget {
  const InputFieldLabel({
    super.key,
    this.bottomPadding = 4,
    required this.label,
  });

  final String label;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: context.grey3,
            ),
      ),
    );
  }
}
