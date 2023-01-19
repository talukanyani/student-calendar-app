import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

import 'package:sc_app/helpers/pad.dart';
import 'package:sc_app/helpers/month_names.dart';
import 'package:sc_app/utils/table_colors.dart';

import '../modals/row_add_form.dart';

import 'table_container.dart';
import 'oval_text_container.dart';

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

  @override
  Widget build(BuildContext context) {
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
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.more_circle),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Consumer<ActivityController>(builder: (context, activity, child) {
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
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.more),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: 40,
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                icon: const Icon(Iconsax.add_circle),
                tooltip: 'Add Activity',
                onPressed: () {
                  showDialog(
                    barrierColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.25),
                    context: context,
                    builder: (BuildContext context) {
                      return RowAddForm(
                        subjectId: subjectId,
                        subjectName: subjectName,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
