import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'modals/verify_alert.dart';
import 'modals/login_alert.dart';

class DataSyncScreen extends StatefulWidget {
  const DataSyncScreen({super.key});

  @override
  State<DataSyncScreen> createState() => _DataSyncScreenState();
}

class _DataSyncScreenState extends State<DataSyncScreen> {
  void _onTurnOn(BuildContext context) {
    final settingProvider = Provider.of<SettingController>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthenticationController>(
      context,
      listen: false,
    );

    var isLoggedIn = authProvider.currentUser != null;
    var isEmailVerified = authProvider.currentUser?.emailVerified ?? false;

    if (!isLoggedIn) {
      Show.modal(context, modal: const LoginAlert());
      return;
    }

    if (!isEmailVerified) {
      Show.modal(context, modal: const VerifyAlert());
      return;
    }

    settingProvider.setSync(true);
  }

  void _onTurnOff(BuildContext context) {
    final settingProvider = Provider.of<SettingController>(
      context,
      listen: false,
    );

    Show.modal(
      context,
      modal: ConfirmationAlert(
        title: const Text('Turn Off?'),
        content: const Text(
          'Are you sure you want turn off synchronisation?',
        ),
        action: () => settingProvider.setSync(false),
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
            value: settingController.isSync,
            onChanged: (value) {
              if (value) {
                _onTurnOn(context);
              } else {
                _onTurnOff(context);
              }
            },
            title: const Text('Data Sync'),
            subtitle: const Text(
              'Automatically back up or sync your '
              'app data (activities and preferences).',
            ),
          ),
        ],
      ),
    );
  }
}
