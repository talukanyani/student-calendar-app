import 'package:flutter/material.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';

import '../../../../../themes/color_scheme.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryTopBar(title: 'Add'),
      body: Body(),
      bottomNavigationBar: BottomBar(screenIndex: 2),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: grey120,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text('Module 1'),
                  IconButton(
                    onPressed: nothing,
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  verticalInside: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                ),
                columnWidths: const <int, TableColumnWidth>{},
                children: const <TableRow>[
                  TableRow(children: [
                    Text('Test'),
                    Text('15-02-2023'),
                    Text('09:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Quiz'),
                    Text('01-03-2023'),
                    Text('09:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Test'),
                    Text('15-02-2023'),
                    Text('09:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Test'),
                    Text('22-03-2023'),
                    Text('10:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 30,
                child: IconButton(
                  onPressed: nothing,
                  icon: Icon(Icons.add_circle_outline),
                  padding: EdgeInsets.all(0),
                  color: grey80,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: grey120,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: const <Widget>[
                  Text('Module 2'),
                  IconButton(
                    onPressed: nothing,
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
              Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  verticalInside: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  top: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                  bottom: BorderSide(
                    color: grey120,
                    width: 1,
                  ),
                ),
                children: const <TableRow>[
                  TableRow(children: [
                    Text('Test'),
                    Text('15-02-2023'),
                    Text('09:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                  TableRow(children: [
                    Text('Quiz'),
                    Text('01-03-2023'),
                    Text('09:00'),
                    IconButton(
                      onPressed: nothing,
                      icon: Icon(Icons.more_vert),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 30,
                child: Center(
                  child: IconButton(
                    onPressed: nothing,
                    icon: Icon(Icons.add_circle_outline),
                    padding: EdgeInsets.all(0),
                    color: grey80,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: grey120,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: const IconButton(
            onPressed: nothing,
            icon: Icon(Icons.add_circle_outline),
          ),
        ),
      ],
    );
  }
}

void nothing() {}
