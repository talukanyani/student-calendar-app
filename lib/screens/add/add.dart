import 'package:flutter/material.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'widgets/subject_table.dart';
import 'widgets/table_add_button.dart';

import 'package:sc_app/data/subject.dart';

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

  static int tablesCount = subjectsData.length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: tablesCount + 1,
      itemBuilder: (context, index) {
        if (index == tablesCount) {
          return const TableAddButton();
        }
        return SubjectTable(
          subjectName: subjectsData[index].subjectName,
          color: subjectsData[index].color,
          activities: subjectsData[index].activities,
        );
      },
    );
  }
}
