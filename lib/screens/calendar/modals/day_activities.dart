import 'package:flutter/material.dart';
import 'package:sc_app/widgets/activities_list.dart';

class DayActivitiesModal extends StatelessWidget {
  const DayActivitiesModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 2,
      insetPadding: const EdgeInsets.all(24),
      insetAnimationDuration: const Duration(seconds: 5),
      insetAnimationCurve: Curves.bounceIn,
      child: SizedBox(
        height: 240,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Today, 1 February',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: ActivitiesList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
