import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'modals/login_alert.dart';

class DataSyncScreen extends StatefulWidget {
  const DataSyncScreen({super.key});

  @override
  State<DataSyncScreen> createState() => _DataSyncScreenState();
}

class _DataSyncScreenState extends State<DataSyncScreen> {
  void _onActivitiesSyncTurnOn(BuildContext context) {
    final settingProvider =
        Provider.of<SettingController>(context, listen: false);
    final authProvider = Provider.of<AuthController>(context, listen: false);

    if (authProvider.currentUser == null) {
      Show.modal(context, modal: const LoginAlert());
      return;
    }

    settingProvider.setActivitiesSync(true);
  }

  void _onActivitiesSyncTurnOff(BuildContext context) {
    final settingProvider = Provider.of<SettingController>(
      context,
      listen: false,
    );

    Show.modal(
      context,
      modal: ConfirmationAlert(
        title: const Text('Turn Off?'),
        content: const Text(
          'Are you sure you want turn off activities sync?',
        ),
        action: () => settingProvider.setActivitiesSync(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Data Sync')),
      body: ListView(
        primary: false,
        children: [
          SwitchListTile(
            value: settingController.isActivitiesSync,
            onChanged: (value) {
              if (value) {
                _onActivitiesSyncTurnOn(context);
              } else {
                _onActivitiesSyncTurnOff(context);
              }
            },
            title: const Text('Activities Sync'),
            subtitle: const Text(
              'Automatically sync or back up your subjects and activities.',
            ),
          ),
        ],
      ),
    );
  }
}
