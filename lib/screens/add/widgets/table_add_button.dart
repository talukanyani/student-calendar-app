import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'subject_table.dart';

class TableAddButton extends StatelessWidget {
  const TableAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.add_circle),
        tooltip: 'Add Module',
      ),
    );
  }
}
