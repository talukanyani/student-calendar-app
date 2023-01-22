import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';

import 'package:sc_app/helpers/pad.dart';
import 'package:sc_app/helpers/month_names.dart';
import 'package:sc_app/utils/table_colors.dart';

import '../modals/row_add_form.dart';
import '../modals/row_edit_form.dart';
import '../modals/table_edit_form.dart';
import '../modals/delete_alert.dart';

import 'table_container.dart';
import 'oval_text_container.dart';
import 'snackbar.dart';

class SubjectTable extends StatelessWidget {
  const SubjectTable({
    super.key,
    required this.tableIndex,
    required this.subjectId,
    required this.subjectName,
    required this.subjectColor,
  });

  final int tableIndex;
  final int subjectId;
  final String subjectName;
  final String subjectColor;

  String getYear(activity) {
    int year = activity.dateTime.year;
    int currYear = DateTime.now().year;

    if (year == currYear) {
      return '';
    }

    return year.toString();
  }

  showModal(BuildContext context, Widget modal) {
    showDialog(
      barrierColor:
          Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
      context: context,
      builder: (context) => modal,
    );
  }

  onPopMenuItemTap(BuildContext context, Widget modal) {
    Navigator.pop(context);

    Future.delayed(
      const Duration(seconds: 1),
      showModal(context, modal),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SubjectController subjectProvider = Provider.of<SubjectController>(
      context,
      listen: false,
    );
    final ActivityController activityProvider = Provider.of<ActivityController>(
      context,
      listen: false,
    );
    return TableContainer(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform: Matrix4.rotationZ(-0.05),
                child: OvalTextContainer(
                  text: Text(
                    subjectName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  color: tableColors[subjectColor],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  icon: const Icon(Iconsax.more_circle),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      child: ListTile(
                        onTap: () => onPopMenuItemTap(
                          context,
                          TableEditForm(
                            subjectId: subjectId,
                            subjectName: subjectName,
                            subjectColor: subjectColor,
                          ),
                        ),
                        title: const Text('Edit'),
                        leading: const Icon(Iconsax.edit, size: 20),
                        visualDensity: const VisualDensity(vertical: -3),
                      ),
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.all(0),
                      child: ListTile(
                        onTap: () => onPopMenuItemTap(
                          context,
                          DeleteAlert(
                            contentName: '$subjectName subject table',
                            deleteContent: () {
                              subjectProvider.removeSubject(subjectId);
                            },
                          ),
                        ),
                        title: const Text('Delete'),
                        leading: const Icon(Iconsax.trash, size: 20),
                        visualDensity: const VisualDensity(vertical: -3),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Consumer<ActivityController>(
            builder: (context, activity, child) {
              final List<ActivityModel> activities =
                  activity.subjectController.subjects[tableIndex].activities;

              return Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1),
                },
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                ),
                children: [
                  const TableRow(
                    children: [
                      OvalTextContainer(
                        text: Text('Activity'),
                        horizontalPadding: 8,
                      ),
                      OvalTextContainer(
                        text: Text('Date'),
                        horizontalPadding: 8,
                      ),
                      OvalTextContainer(
                        text: Text('Time'),
                        horizontalPadding: 8,
                      ),
                      SizedBox(
                        height: 24,
                        child: Text(''),
                      ),
                    ],
                  ),
                  ...List.generate(
                    activities.length,
                    (index) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(activities[index].activity),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${padTwoNums(activities[index].dateTime.day)} ${getMonthName(activities[index].dateTime.month - 1)} ${getYear(activities[index])}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '${padTwoNums(activities[index].dateTime.hour)}:${padTwoNums(activities[index].dateTime.minute)}',
                          ),
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: SizedBox(
                            height: 40,
                            child: PopupMenuButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(Iconsax.more),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  padding: const EdgeInsets.all(0),
                                  child: ListTile(
                                    onTap: () => onPopMenuItemTap(
                                      context,
                                      RowEditForm(
                                        subjectId: subjectId,
                                        subjectName: subjectName,
                                        activity: activities[index],
                                      ),
                                    ),
                                    title: const Text('Edit'),
                                    leading: const Icon(Iconsax.edit, size: 20),
                                    visualDensity:
                                        const VisualDensity(vertical: -3),
                                  ),
                                ),
                                PopupMenuItem(
                                  padding: const EdgeInsets.all(0),
                                  child: ListTile(
                                    onTap: () => onPopMenuItemTap(
                                      context,
                                      DeleteAlert(
                                        contentName:
                                            '${activities[index].activity} activity row',
                                        deleteContent: () {
                                          activityProvider.removeActivity(
                                            subjectId,
                                            activities[index].id,
                                          );
                                        },
                                      ),
                                    ),
                                    title: const Text('Delete'),
                                    leading:
                                        const Icon(Iconsax.trash, size: 20),
                                    visualDensity:
                                        const VisualDensity(vertical: -3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Material(
              type: MaterialType.transparency,
              child: OutlinedButton(
                onPressed: () {
                  if (subjectProvider.subjects[tableIndex].activities.length >=
                      50) {
                    showFeedback(
                      context,
                      'You have reached maximum number of activity rows.',
                    );
                    return;
                  }

                  showModal(
                    context,
                    RowAddForm(
                      subjectId: subjectId,
                      subjectName: subjectName,
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onBackground,
                ),
                child: const Text('ADD ACTIVITY'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
