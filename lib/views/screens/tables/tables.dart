import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/controllers/setting.dart' show TablesSort;
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/main_drawer.dart';
import 'package:sc_app/views/widgets/settings_icon_button.dart';
import 'package:sc_app/views/widgets/side_nav_bar.dart';

import 'widgets/subject_add_button.dart';
import 'widgets/table.dart';

class TablesScreen extends StatelessWidget {
  const TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;
    final isDrawer = (availWidth >= 600);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isDrawer,
        title: const Text('Tables'),
        actions: [
          !isDrawer ? const SettingsIconButton() : const SizedBox(),
        ],
      ),
      body: SideNavBar(
        screenIndex: 1,
        isVisible: isDrawer,
        child: const Tables(),
      ),
      bottomNavigationBar: isDrawer ? null : const BottomNavBar(screenIndex: 1),
      drawer: isDrawer ? const MainDrawer(screenIndex: 1) : null,
    );
  }
}

class Tables extends ConsumerWidget {
  const Tables({super.key});

  static final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availWidth = MediaQuery.of(context).size.width;

    final subjects = ref.watch(subjectsAndActivitiesProvider);
    var subjectsCount = subjects.length;

    sortedSubjects() {
      switch (ref.watch(tablesSortProvider)) {
        case TablesSort.name:
          subjects.sort((a, b) => a.name.compareTo(b.name));
          break;
        case TablesSort.dateAdded:
          subjects.sort((a, b) => a.id.compareTo(b.id));
      }

      return subjects;
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: (availWidth < 560)
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: (availWidth - 560) / 2),
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
