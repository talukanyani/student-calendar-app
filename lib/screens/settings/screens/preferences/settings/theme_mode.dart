import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/modal.dart';

class ThemeModeSettingModal extends StatelessWidget {
  const ThemeModeSettingModal({super.key});

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    RadioListTile option(ThemeMode value) {
      return RadioListTile(
        value: value,
        groupValue: settingController.themeMode,
        onChanged: (value) => settingController.setTheme(value),
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(value.title),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        option(ThemeMode.light),
        option(ThemeMode.dark),
        option(ThemeMode.system),
      ],
    );
  }
}
