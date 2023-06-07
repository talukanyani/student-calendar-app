import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';

class Modal extends StatelessWidget {
  const Modal({super.key, required this.children, this.insetPadding = 16});

  final List<Widget> children;
  final double insetPadding;

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: context.grey1,
      child: Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
        insetPadding: EdgeInsets.all(insetPadding),
        insetAnimationDuration: const Duration(milliseconds: 300),
        insetAnimationCurve: Curves.ease,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: children,
        ),
      ),
    );
  }
}
