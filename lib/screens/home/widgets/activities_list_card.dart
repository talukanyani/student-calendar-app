import 'package:flutter/material.dart';

class ActivitiesListCard extends StatelessWidget {
  const ActivitiesListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 64,
            spreadRadius: -32,
            offset: const Offset(8, -16),
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: const [
          Text('Today'),
          Text('You have no activities today.'),
        ],
      ),
    );
  }
}
