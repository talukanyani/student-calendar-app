import 'package:flutter/material.dart';
import 'package:sc_app/widgets/bullet_list.dart';
import 'package:sc_app/widgets/modal.dart';

class SyncReasons extends StatelessWidget {
  const SyncReasons({super.key});

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'Why you should turn on synchronisation?',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 16),
        BulletList(texts: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lost Device/App',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Text(
                'If you lose/damage your device, you will be able to get back your data/activities when you log back in on this app using the other device.',
              ),
              const SizedBox(height: 8),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Using Two or More Devices',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Text(
                'If you are using this app on two or more devices and logged in using the same profile, you will access the same data/activities on both of your devices.',
              ),
            ],
          ),
        ])
      ],
    );
  }
}
