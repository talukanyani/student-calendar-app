import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(color: CustomColorScheme.grey3),
      ),
    );
  }
}
