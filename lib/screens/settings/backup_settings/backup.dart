import 'package:flutter/material.dart';

class BackupSettings extends StatelessWidget {
  const BackupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup')),
      body: const Center(child: Text('BackupSettings')),
    );
  }
}
