import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import '../modals/row_add_form.dart';

class RowAddButton extends StatelessWidget {
  const RowAddButton({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: IconButton(
        onPressed: () {
          if (subject.activities.length >= 100) {
            Show.snackBar(
              context,
              text: 'You have reached maximum number '
                  'of activities for ${subject.name}',
              snackBarIcon: SnackBarIcon.info,
            );
          } else {
            Show.modal(
              context,
              modal: RowAddForm(subject: subject),
            );
          }
        },
        tooltip: 'Add activity',
        icon: const Icon(Iconsax.add_square),
      ),
    );
  }
}
