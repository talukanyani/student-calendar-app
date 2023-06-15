import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/views/modals/add_subject.dart';

class SubjectAddButton extends StatelessWidget {
  const SubjectAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 16),
      child: OutlinedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => const AddSubjectModal(),
        ),
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
