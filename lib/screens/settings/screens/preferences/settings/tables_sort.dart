import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/modal.dart';

class TablesSortSettingModal extends StatelessWidget {
  const TablesSortSettingModal({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    RadioListTile option(TablesSortSetting value) {
      return RadioListTile(
        value: value,
        groupValue: settingController.tablesSort,
        onChanged: (value) {
          settingController.setTablesSort(value);
          Navigator.pop(context);
        },
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(value.title),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        option(TablesSortSetting.name),
        option(TablesSortSetting.dateAdded),
      ],
    );
  }
}
