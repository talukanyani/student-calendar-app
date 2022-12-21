import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'package:sc_app/screens/add/modals/row_add_modal_sheet.dart';

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
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        Container(
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Module 1',
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
                  3: FlexColumnWidth(1.5),
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
                children: <TableRow>[
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
                  TableRow(
                    children: [
                      const Text('Test'),
                      const Text('15-02-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Quiz'),
                      const Text('01-03-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Test'),
                      const Text('15-02-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Test'),
                      const Text('22-03-2023'),
                      const Text('10:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
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
        ),
        Container(
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
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Module 2',
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
                  3: FlexColumnWidth(1.5),
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
                children: <TableRow>[
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
                  TableRow(
                    children: [
                      const Text('Test'),
                      const Text('15-02-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Quiz'),
                      const Text('01-03-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Test'),
                      const Text('15-02-2023'),
                      const Text('09:00'),
                      SizedBox(
                        height: 40,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Iconsax.more),
                        ),
                      ),
                    ],
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
        ),
        Container(
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
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.add_circle),
            tooltip: 'Add Module',
          ),
        ),
      ],
    );
  }
}
