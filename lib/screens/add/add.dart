import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'widgets/table.dart';
import 'widgets/table_add_button.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryTopBar(title: 'Add'),
      body: Tables(),
      bottomNavigationBar: BottomBar(screenIndex: 1),
    );
  }
}

class Tables extends StatelessWidget {
  const Tables({super.key});

  @override
  Widget build(BuildContext context) {
    final subjectController = Provider.of<SubjectController>(context);
    final subjects = subjectController.subjects;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: subjects.length + 1,
      itemBuilder: (context, index) {
        if (index == subjects.length) return const TableAddButton();
        return SubjectTable(subject: subjects[index]);
      },
    );
  }
}
