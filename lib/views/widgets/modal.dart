import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.insetPadding = 16,
    required this.children,
  });

  final EdgeInsets padding;
  final double insetPadding;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 2,
      insetPadding: EdgeInsets.all(insetPadding),
      insetAnimationDuration: const Duration(milliseconds: 300),
      insetAnimationCurve: Curves.ease,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: padding,
        children: children,
      ),
    );
  }
}
