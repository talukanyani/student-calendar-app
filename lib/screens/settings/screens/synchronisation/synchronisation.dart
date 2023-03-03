import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'modals/sync_info.dart';
import 'modals/sync_reasons.dart';

class SynchronisationSettings extends StatefulWidget {
  const SynchronisationSettings({super.key});

  @override
  State<SynchronisationSettings> createState() =>
      _SynchronisationSettingsState();
}

class _SynchronisationSettingsState extends State<SynchronisationSettings> {
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
              title: const Text('Synchronise'),
              subtitle: const Text('Turn synchronisation on/off'),
              trailing: Switch(
                value: settingController.isSync,
                onChanged: (value) {
                  if (!value) {
                    Show.modal(
                      context,
                      modal: ConfirmationAlert(
                        title: const Text('Turn Off?'),
                        content: const Text(
                          'Are you sure you want turn off synchronisation?',
                        ),
                        action: () => settingController.setSync(value),
                      ),
                    );
                  } else {
                    settingController.setSync(value);
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
