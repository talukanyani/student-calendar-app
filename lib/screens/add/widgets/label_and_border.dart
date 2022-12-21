import 'package:flutter/material.dart';

class LabelAndBorderContainer extends StatelessWidget {
  const LabelAndBorderContainer({
    super.key,
    required this.label,
    this.value = ' ',
    required this.child,
  });

  final Widget child;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 16,
            bottom: 8,
          ),
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 8,
            left: 8,
            right: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).primaryColorLight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
        Positioned(
          left: 16,
          top: 5,
          child: ClipOval(
            child: Container(
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: 16,
                right: 32,
              ),
              color: Theme.of(context).primaryColorLight,
              child: Text(
                '$label: $value',
              ),
            ),
          ),
        )
      ],
    );
  }
}
