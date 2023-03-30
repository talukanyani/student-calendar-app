import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'modals/sync_info.dart';
import 'modals/sync_reasons.dart';
import 'modals/verify_alert.dart';
import 'modals/login_alert.dart';

class SynchronisationSettings extends StatefulWidget {
  const SynchronisationSettings({super.key});

  @override
  State<SynchronisationSettings> createState() =>
      _SynchronisationSettingsState();
}

class _SynchronisationSettingsState extends State<SynchronisationSettings> {
  void _onTurnOn(BuildContext context, SettingController settingController) {
    final user = Provider.of<AuthenticationController>(
      context,
      listen: false,
    ).currentUser;
    var isLoggedIn = user != null;
    var isEmailVerified = user?.emailVerified ?? false;

    if (!isLoggedIn) {
      Show.modal(context, modal: const LoginAlert());
      return;
    }

    if (!isEmailVerified) {
      Show.modal(context, modal: const VerifyAlert());
      return;
    }

    settingController.setSync(true);
  }

  void _onTurnOff(BuildContext context, SettingController settingController) {
    Show.modal(
      context,
      modal: ConfirmationAlert(
        title: const Text('Turn Off?'),
        content: const Text(
          'Are you sure you want turn off synchronisation?',
        ),
        action: () => settingController.setSync(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingController = Provider.of<SettingController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Synchronisation')),
      body: ListView(
        primary: false,
        children: [
          RectContainer(
            child: ListTile(
              title: const Text('Data Sync'),
              subtitle: const Text('Turn data sync on/off'),
              trailing: Switch(
                value: settingController.isSync,
                onChanged: (value) {
                  if (value) {
                    _onTurnOn(context, settingController);
                  } else {
                    _onTurnOff(context, settingController);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    Show.modal(context, modal: const SyncInformaition());
                  },
                  child: const Text(
                    'What is synchronisation?',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Show.modal(context, modal: const SyncReasons());
                  },
                  child: const Text(
                    'Why should I turn on synchronisation?',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
