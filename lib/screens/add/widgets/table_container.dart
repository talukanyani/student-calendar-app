import 'package:flutter/material.dart';

class TableContainer extends StatelessWidget {
  const TableContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
