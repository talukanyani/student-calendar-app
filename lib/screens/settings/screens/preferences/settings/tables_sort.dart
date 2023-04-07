import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/modal.dart';

class TablesSortSettingModal extends ConsumerWidget {
  const TablesSortSettingModal({super.key});

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
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(value.title),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        option(TablesSort.name),
        option(TablesSort.dateAdded),
      ],
    );
  }
}
