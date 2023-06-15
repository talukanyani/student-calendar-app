import 'package:flutter/material.dart';

class RectContainer extends StatelessWidget {
  const RectContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(0),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0.2, 0.4),
            color: Theme.of(context).colorScheme.shadow,
          ),
        ],
      ),
      child: child,
    );
  }
}
