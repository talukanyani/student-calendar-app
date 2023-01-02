import 'package:flutter/material.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({super.key});

  static List<Map<String, String>> activities = <Map<String, String>>[
    {
      'subject': 'Module 1',
      'activity': 'Test 1',
      'time': '09:00',
    },
    {
      'subject': 'Module 2',
      'activity': 'Quiz 3',
      'time': '23:59',
    },
    {
      'subject': 'Module 1',
      'activity': 'Assignment 2',
      'time': '23:59',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const Center(
        child: TextBox(text: 'You have no activity on this day'),
      );
    }

    return ListView.builder(
      itemExtent: 48,
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Column(
            children: <Widget>[
              index == 0 ? const SizedBox(height: 12) : const VertLine(),
              TextBox(text: activities[index]['time'].toString()),
              index == (activities.length - 1)
                  ? const SizedBox(height: 12)
                  : const VertLine(),
            ],
          ),
          title: Text(
            "${activities[index]['subject']} ${activities[index]['activity']}",
            style: const TextStyle(fontSize: 15),
          ),
        );
      },
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

class TextBox extends StatelessWidget {
  const TextBox({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text),
    );
  }
}
