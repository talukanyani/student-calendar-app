import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import '../../modals/login_alert.dart';

class DataSyncScreen extends ConsumerStatefulWidget {
  const DataSyncScreen({super.key});

  @override
  ConsumerState<DataSyncScreen> createState() => _DataSyncScreenState();
}

class _DataSyncScreenState extends ConsumerState<DataSyncScreen> {
  void _onActivitiesSyncTurnOn(BuildContext context) {
    final isLoggedIn = ref.watch(userProvider) != null;

    if (isLoggedIn) {
      ref.read(dataSyncProvider.notifier).set(true);
    } else {
      showDialog(
        context: context,
        builder: (context) => const LoginAlert(
          message: Text(
            'To turn on data sync, you have to log in with your profile.',
          ),
        ),
      );
    }
  }

  void _onActivitiesSyncTurnOff(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationAlert(
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
    final isLoggedIn = ref.watch(userProvider) != null;

    return Scaffold(
      appBar: AppBar(title: const Text('Data Sync')),
      body: ListView(
        primary: false,
        children: [
          SwitchListTile(
            value: (ref.watch(dataSyncProvider) && isLoggedIn),
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
