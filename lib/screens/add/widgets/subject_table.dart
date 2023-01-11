import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/helpers/mounth_names.dart';

import 'package:sc_app/themes/colors.dart';

import '../../../helpers/pad.dart';
import '../modals/row_add_modal_sheet.dart';

import 'table_container.dart';
import 'oval_text_container.dart';

class SubjectTable extends StatelessWidget {
  const SubjectTable({
    super.key,
    required this.subjectName,
    required this.color,
    required this.activities,
  });

  final String subjectName;
  final String color;
  final Set<Map<String, dynamic>> activities;

  static Map<String, Color> headingBgColors = {
    'baby_blue': CustomColors.babyBlueEyes,
    'fresh_air_blue': CustomColors.freshAirBlue,
    'calamansi': CustomColors.calamnsi,
    'peach': CustomColors.peach,
    'deep_peach': CustomColors.deepPeach,
    'melon': CustomColors.melon,
    'salmon_pink': CustomColors.salmonPink,
    'pale_magenta_pink': CustomColors.paleMagentaPink,
    'pale_violet': CustomColors.paleViolet,
    'mauve_violet': CustomColors.mauveViolet,
  };

  DateTime getDate(index) {
    return activities.elementAt(index)["date"]!;
  }

  String getYear(index) {
    int year = getDate(index).year;
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
                  color: headingBgColors[color],
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
          Table(
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
                      child: Text(activities.elementAt(index)["activity"]!),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${padTwoNums(getDate(index).day)} ${getMonthName(getDate(index).month - 1)} ${getYear(index)}',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${padTwoNums(getDate(index).hour)}:${padTwoNums(getDate(index).minute)}',
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
          ),
          SizedBox(
            height: 40,
            child: Material(
              type: MaterialType.transparency,
              child: IconButton(
                icon: const Icon(Iconsax.add_circle),
                tooltip: 'Add Activity',
                onPressed: () {
                  showModalBottomSheet(
                    barrierColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.2),
                    context: context,
                    builder: (BuildContext context) {
                      return const RowAddModalSheet();
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
