import 'package:flutter/material.dart';
import 'package:sc_app/widgets/bullet_list.dart';
import 'package:sc_app/widgets/modal.dart';

class SyncInformaition extends StatelessWidget {
  const SyncInformaition({super.key});

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'If synchronisation is turned on:',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const BulletList(
          texts: [
            Text(
              'Your data such as activities and settings will be stored in a cloud.',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'If synchronisation is turned off:',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const BulletList(
          texts: [
            Text(
              'Your data such as activities and settings will be cached only on this app.',
            ),
          ],
        ),
      ],
    );
  }
}
