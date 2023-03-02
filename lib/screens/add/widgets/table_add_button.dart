import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import '../modals/table_add_form.dart';

class TableAddButton extends StatelessWidget {
  const TableAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectProvider =
        Provider.of<SubjectController>(context, listen: false);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: OutlinedButton(
        onPressed: () {
          if (subjectProvider.subjects.length >= 20) {
            Show.snackBar(
              context,
              text: 'You have reached maximum number of subjects.',
              snackBarIcon: SnackBarIcon.info,
            );
          } else {
            Show.modal(context, modal: const TableAddForm());
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        child: const Text('ADD SUBJECT'),
      ),
    );
  }
}
