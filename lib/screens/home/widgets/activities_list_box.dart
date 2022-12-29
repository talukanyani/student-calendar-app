import 'package:flutter/material.dart';

class ActivitiesListBox extends StatelessWidget {
  const ActivitiesListBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 8,
              bottom: 4,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor.withOpacity(0.4),
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Today',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              itemExtent: 48,
              children: <Widget>[
                ListTile(
                  leading: Column(
                    children: <Widget>[
                      const SizedBox(height: 12),
                      Container(
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('09:30'),
                      ),
                      const VertLine(),
                    ],
                  ),
                  title: Text(
                    'Module 1 Test 1',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  ),
                ),
                ListTile(
                  leading: Column(
                    children: <Widget>[
                      const VertLine(),
                      Container(
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('23:59'),
                      ),
                      const VertLine(),
                    ],
                  ),
                  title: Text(
                    'Module 2 Quiz 3',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  ),
                ),
                ListTile(
                  leading: Column(
                    children: <Widget>[
                      const VertLine(),
                      Container(
                        height: 24,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('23:59'),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                  title: Text(
                    'Module 1 Assignment 2',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.headline5?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VertLine extends StatelessWidget {
  const VertLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 2,
      color: Theme.of(context).primaryColorLight,
    );
  }
}
