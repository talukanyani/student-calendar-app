import 'package:flutter/material.dart';

class OvalTextContainer extends StatelessWidget {
  const OvalTextContainer({
    super.key,
    required this.text,
    this.horizontalPadding = 16,
    this.color,
  });

  final Text text;
  final double horizontalPadding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: horizontalPadding / 4,
          horizontal: horizontalPadding,
        ),
        alignment: Alignment.center,
        color: color ?? Theme.of(context).colorScheme.surfaceVariant,
        child: text,
      ),
    );
  }
}
