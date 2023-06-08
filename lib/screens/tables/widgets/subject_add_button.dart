import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import '../modals/subject_add_form.dart';

class SubjectAddButton extends StatelessWidget {
  const SubjectAddButton({super.key, required this.subjectsCount});

  final int subjectsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 16),
      child: OutlinedButton(
        onPressed: () {
          if (subjectsCount >= 20) {
            Show.snackBar(
              context,
              text: 'You have reached maximum number of subjects.',
              snackBarIcon: SnackBarIcon.info,
            );
          } else {
            Show.modal(context, modal: const SubjectAddForm());
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: Theme.of(context).colorScheme.onBackground),
          minimumSize: const Size(0, 0),
        ),
        child: const Icon(Iconsax.add),
      ),
    );
  }
}
