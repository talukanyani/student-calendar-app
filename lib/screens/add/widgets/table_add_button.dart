import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'table_container.dart';
import '../modals/table_add_modal.dart';

class TableAddButton extends StatelessWidget {
  const TableAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TableContainer(
      child: RawMaterialButton(
        onPressed: () {
          showDialog(
            barrierColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            context: context,
            builder: (context) => const TableAddModal(),
          );
        },
        child: const Icon(Iconsax.add_circle),
      ),
    );
  }
}
