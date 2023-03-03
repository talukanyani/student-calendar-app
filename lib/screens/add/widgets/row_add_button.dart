import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import '../modals/row_add_form.dart';

class RowAddButton extends StatelessWidget {
  const RowAddButton({
    super.key,
    required this.subjectTimeId,
    required this.subjectName,
  });

  final int subjectTimeId;
  final String subjectName;

  @override
  Widget build(BuildContext context) {
    final activityProvider =
        Provider.of<ActivityController>(context, listen: false);
    final activitiesCount =
        activityProvider.subjectActivities(subjectTimeId).length;

    return OutlinedButton(
      onPressed: () {
        if (activitiesCount >= 50) {
          Show.snackBar(
            context,
            text:
                'You have reached maximum number of activities for $subjectName.',
            snackBarIcon: SnackBarIcon.info,
          );
        } else {
          Show.modal(
            context,
            modal: RowAddForm(
              subjectTimeId: subjectTimeId,
              subjectName: subjectName,
            ),
          );
        }
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      child: const Text('ADD ACTIVITY'),
    );
  }
}
