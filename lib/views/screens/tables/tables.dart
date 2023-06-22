import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/setting.dart' show TablesSort;
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/profile_icon_button.dart';

import 'widgets/subject_add_button.dart';
import 'widgets/table.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tables'),
        actions: const [ProfileIconButton()],
      ),
      body: const Tables(),
      bottomNavigationBar: const BottomNavBar(screenIndex: 1),
    );
  }
}

class Tables extends ConsumerWidget {
  const Tables({super.key});

  static final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsAndActivitiesProvider);
    var subjectsCount = subjects.length;

    sortedSubjects() {
      switch (ref.watch(tablesSortProvider)) {
        case TablesSort.name:
          subjects.sort((a, b) => a.name.compareTo(b.name));
          break;
        default: // case TablesSort.dateAdded:
          subjects.sort((a, b) => a.id.compareTo(b.id));
      }

      return subjects;
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: subjectsCount + 1,
      itemBuilder: (context, index) {
        if (index == subjectsCount) {
          return SubjectAddButton(controller: _scrollController);
        }

        return SubjectTable(subject: sortedSubjects()[index]);
      },
    );
  }
}
