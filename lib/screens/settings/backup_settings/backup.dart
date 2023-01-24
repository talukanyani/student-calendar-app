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
  String backupSettingValue = 'on_save';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        RectContainer(
          child: ListTile(
            title: const Text('Backup'),
            subtitle: const Text('Turn on/off backup'),
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
                  RadioListTile(
                    value: 'on_save',
                    groupValue: backupSettingValue,
                    onChanged: (value) {
                      setState(() => backupSettingValue = value!);
                    },
                    title: const Text('Automatically backup on save'),
                  ),
                  RadioListTile(
                    value: 'every_week',
                    groupValue: backupSettingValue,
                    onChanged: (value) {
                      setState(() => backupSettingValue = value!);
                    },
                    title: const Text('Automatically backup every week'),
                  ),
                  RadioListTile(
                    value: 'manually',
                    groupValue: backupSettingValue,
                    onChanged: (value) {
                      setState(() => backupSettingValue = value!);
                    },
                    title: const Text('Manually backup'),
                  ),
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
