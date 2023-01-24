import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/subject.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'widgets/subject_table.dart';
import 'widgets/table_add_button.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryTopBar(title: 'Add'),
      body: Body(),
      bottomNavigationBar: BottomBar(screenIndex: 1),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SubjectController>(
      builder: (context, subject, child) {
        final List<SubjectModel> subjectData = subject.subjects;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: subjectData.length + 1,
          itemBuilder: (context, index) {
            if (index == subjectData.length) {
              return const TableAddButton();
            }
            return SubjectTable(
              tableIndex: index,
              subjectId: subjectData[index].id,
              subjectName: subjectData[index].name,
              subjectColor: subjectData[index].color,
            );
          },
        );
      },
    );
  }
}
