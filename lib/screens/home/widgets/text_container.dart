import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).backgroundColor,
            Theme.of(context).backgroundColor.withOpacity(0.75),
            Theme.of(context).backgroundColor.withOpacity(0.50),
            Theme.of(context).backgroundColor.withOpacity(0.25),
            Theme.of(context).backgroundColor.withOpacity(0.00),
          ],
        ),
      ),
      child: child,
    );
  }
}
