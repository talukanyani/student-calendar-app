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
    final SubjectController subjectProvider =
        Provider.of<SubjectController>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: OutlinedButton(
            onPressed: () {
              if (subjectProvider.subjects.length >= 20) {
                Show.snackBar(
                  context,
                  text: 'You have reached maximum number of subject tables.',
                  snackBarIcon: SnackBarIcon.info,
                );
                return;
              }

              Show.modal(
                context,
                modal: const TableAddForm(),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
            ),
            child: const Text('ADD SUBJECT'),
          ),
        ),
      ],
    );
  }
}
