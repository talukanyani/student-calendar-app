import 'package:flutter/material.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'package:sc_app/screens/calendar/widgets/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryTopBar(title: 'Calendar'),
      body: Calendar(),
      bottomNavigationBar: BottomBar(screenIndex: 2),
    );
  }
}
