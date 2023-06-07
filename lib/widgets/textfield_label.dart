import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({super.key, required this.text, this.bottomPadding});

  final String text;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: context.grey3,
            ),
      ),
    );
  }
}
