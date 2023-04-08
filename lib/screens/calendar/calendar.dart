import 'package:flutter/material.dart';
import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'widgets/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryTopBar(title: 'Calendar'),
      body: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              primary: false,
              children: [
                Container(
                  height: constraints.maxHeight,
                  constraints: const BoxConstraints(minHeight: 520),
                  child: const Calendar(),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomBar(screenIndex: 2),
    );
  }
}
