import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'modals/login_alert.dart';

class DataSyncScreen extends ConsumerStatefulWidget {
  const DataSyncScreen({super.key});

  @override
  ConsumerState<DataSyncScreen> createState() => _DataSyncScreenState();
}

class _DataSyncScreenState extends ConsumerState<DataSyncScreen> {
  void _onActivitiesSyncTurnOn(BuildContext context) {
    if (!ref.watch(isLoggedInProvider)) {
      Show.modal(context, modal: const LoginAlert());
      return;
    }

    ref.read(dataSyncProvider.notifier).set(true);
  }

  void _onActivitiesSyncTurnOff(BuildContext context) {
    Show.modal(
      context,
      modal: ConfirmationAlert(
        title: const Text('Turn Off?'),
        content: const Text(
          'Are you sure you want turn off activities sync?',
        ),
        action: () => ref.read(dataSyncProvider.notifier).set(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Sync')),
      body: ListView(
        primary: false,
        children: [
          SwitchListTile(
            value: ref.watch(dataSyncAndAuthedProvider),
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
