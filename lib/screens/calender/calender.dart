import 'package:flutter/material.dart';

import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PrimaryTopBar(title: 'Calender'),
      body: Center(
        child: Text('This is Calender Screen'),
      ),
      bottomNavigationBar: BottomBar(screenIndex: 2),
    );
  }
}
