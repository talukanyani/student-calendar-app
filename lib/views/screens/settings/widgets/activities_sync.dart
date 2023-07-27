import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/views/widgets/alerts.dart';

import '../modals/sign_in_alert.dart';

class ActivitiesSync extends ConsumerWidget {
  const ActivitiesSync({super.key});

  void _onTurnOn(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userProvider) != null;

    if (isLoggedIn) {
      ref.read(dataSyncProvider.notifier).set(true);
    } else {
      showDialog(
        context: context,
        builder: (context) => const SignInAlert(
          message: Text(
            'You have to log in, to sync and back up '
            'your subjects and activities.',
          ),
        ),
      );
    }
  }

  void _onTurnOff(BuildContext context, WidgetRef ref) {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(userProvider) != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Activities Sync'),
          subtitle:
              const Text('Automatically sync and back up your activities.'),
          leading: const Icon(FluentIcons.cloud_24_filled),
          trailing: Switch(
            value: (ref.watch(dataSyncProvider) && isLoggedIn),
            onChanged: (value) {
              if (value) {
                _onTurnOn(context, ref);
              } else {
                _onTurnOff(context, ref);
              }
            },
          ),
        ),
      ],
    );
  }
}
