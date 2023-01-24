import 'package:flutter/material.dart';

import 'package:sc_app/helpers/show_modal.dart';

import 'package:sc_app/widgets/rect_container.dart';
import 'modals/turn_off_alert.dart';

class BackupSettings extends StatelessWidget {
  const BackupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Backup')),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isBackup = false;
  String backupTime = 'on_save';

  RadioListTile backupTimeOption({
    required String title,
    required String value,
  }) {
    return RadioListTile(
      value: value,
      groupValue: backupTime,
      onChanged: (value) => setState(() => backupTime = value!),
      title: Text(title, style: const TextStyle(fontSize: 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RectContainer(
          child: ListTile(
            title: const Text('Backup'),
            subtitle: const Text('Turn backup on/off'),
            trailing: Switch(
              value: isBackup,
              onChanged: (value) {
                if (!value) {
                  showModal(
                    context,
                    modal: TurnOffAlert(
                      turnOff: () => setState(() => isBackup = value),
                    ),
                  );
                  return;
                }
                setState(() => isBackup = value);
              },
            ),
          ),
        ),
        AbsorbPointer(
          absorbing: !isBackup,
          child: Opacity(
            opacity: !isBackup ? 0.5 : 1,
            child: RectContainer(
              child: Column(
                children: [
                  backupTimeOption(
                    title: 'Automatically Backup On Save',
                    value: 'on_save',
                  ),
                  backupTimeOption(
                    title: 'Automatically Backup Every Week',
                    value: 'every_week',
                  ),
                  backupTimeOption(title: 'Manually Backup', value: 'manually'),
                ],
              ),
            ),
          ),
        ),
        AbsorbPointer(
          absorbing: !isBackup,
          child: Opacity(
            opacity: !isBackup ? 0.5 : 1,
            child: RectContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Backup Status',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 16),
                  ClipOval(
                    child: Container(
                      height: 24,
                      width: 24,
                      color: Theme.of(context).disabledColor,
                      alignment: Alignment.center,
                      child: const Icon(Icons.done, size: 20),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('No status.'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 32,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      child: const Text('Manually Backup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
