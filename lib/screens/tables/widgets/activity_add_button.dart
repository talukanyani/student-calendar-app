import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/screens/add_activities/add_activities.dart';

class ActivityAddButton extends StatelessWidget {
  const ActivityAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddActivityScreen()),
        ),
        tooltip: 'add an activity',
        icon: const Icon(Iconsax.add_square),
      ),
    );
  }
}
