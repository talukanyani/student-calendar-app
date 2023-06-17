import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/views/widgets/modal.dart';

class TablesSortModal extends ConsumerWidget {
  const TablesSortModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RadioListTile<TablesSort> option(TablesSort value) {
      return RadioListTile(
        value: value,
        groupValue: ref.watch(tablesSortProvider),
        onChanged: (value) {
          ref.read(tablesSortProvider.notifier).set(value ?? TablesSort.name);
          Navigator.pop(context);
        },
        title: Text(value.title),
        visualDensity: const VisualDensity(vertical: -3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        Text(
          'Sort By:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        option(TablesSort.name),
        option(TablesSort.dateAdded),
      ],
    );
  }
}
