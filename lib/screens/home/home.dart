import 'package:flutter/material.dart';

import 'package:sc_app/widgets/home_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeTopBar(),
      body: Center(
        child: Text('This is SC App'),
      ),
    );
  }
}
