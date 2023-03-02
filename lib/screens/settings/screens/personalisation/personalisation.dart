import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/rect_container.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  RadioListTile _themeOption({
    required String title,
    required ThemeMode value,
    required SettingController settingController,
  }) {
    return RadioListTile(
      value: value,
      groupValue: settingController.themeMode,
      onChanged: (value) => settingController.setTheme(value),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  RadioListTile _sortTablesOption({
    required String title,
    required TablesSortSetting value,
    required SettingController settingController,
  }) {
    return RadioListTile(
      value: value,
      groupValue: settingController.tablesSort,
      onChanged: (value) => settingController.setTablesSort(value),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  RadioListTile _calendarWeekOption({
    required String title,
    required int value,
    required SettingController settingController,
  }) {
    return RadioListTile(
      value: value,
      groupValue: settingController.weekStartDay,
      onChanged: (value) => settingController.setWeekStart(value),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Personalise')),
      body: ListView(
        primary: false,
        children: [
          // RectContainer(
          //   padding: const EdgeInsets.all(8),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const HeadingText(text: 'Theme Mode'),
          //       _themeOption(
          //         title: 'Light',
          //         value: ThemeMode.light,
          //         settingController: settingProvider,
          //       ),
          //       _themeOption(
          //         title: 'Dark',
          //         value: ThemeMode.dark,
          //         settingController: settingProvider,
          //       ),
          //       _themeOption(
          //         title: 'System Default',
          //         value: ThemeMode.system,
          //         settingController: settingProvider,
          //       ),
          //     ],
          //   ),
          // ),
          RectContainer(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingText(text: 'Sort Tables'),
                _sortTablesOption(
                  title: 'Date Added',
                  value: TablesSortSetting.dateAdded,
                  settingController: settingProvider,
                ),
                _sortTablesOption(
                  title: 'Name',
                  value: TablesSortSetting.name,
                  settingController: settingProvider,
                ),
              ],
            ),
          ),
          RectContainer(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingText(text: 'Calendar Week Start Day'),
                _calendarWeekOption(
                  title: 'Monday',
                  value: DateTime.monday,
                  settingController: settingProvider,
                ),
                _calendarWeekOption(
                  title: 'Sunday',
                  value: DateTime.sunday,
                  settingController: settingProvider,
                ),
                _calendarWeekOption(
                  title: 'Saturday',
                  value: DateTime.saturday,
                  settingController: settingProvider,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
