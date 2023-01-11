import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'table_container.dart';

class TableAddButton extends StatelessWidget {
  const TableAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      child: RawMaterialButton(
        onPressed: () {},
        child: const Icon(Iconsax.add_circle),
      ),
    );
  }
}
