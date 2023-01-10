import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../modals/row_add_modal_sheet.dart';

class TableContainer extends StatelessWidget {
  const TableContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 2,
            offset: const Offset(0.2, 0.4),
            color: Theme.of(context).colorScheme.shadow,
          ),
        ],
      ),
      child: child,
    );
  }
}

class SubjectTable extends StatelessWidget {
  const SubjectTable({
    super.key,
    required this.subjectName,
    required this.activities,
  });

  final String subjectName;
  final Set<Map<String, String>> activities;

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                subjectName,
                style: Theme.of(context).textTheme.headline5,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.more_circle),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(3.5),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(2),
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
                  Text('Activity'),
                  Text('Date'),
                  Text('Time'),
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
                    Text(activities.elementAt(index)["activity"]!),
                    Text(activities.elementAt(index)["date"]!),
                    Text(activities.elementAt(index)["time"]!),
                    SizedBox(
                      height: 40,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.more),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
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
        ],
      ),
    );
  }
}
