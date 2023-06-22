import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  const BulletList({super.key, required this.texts});

  final List<Widget> texts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        for (final text in texts)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              const Text('\u2022', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: text,
                ),
              ),
            ],
          ),
        const SizedBox(height: 4),
      ],
    );
  }
}
