import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/buttons.dart';

class SendResponseScreen extends StatelessWidget {
  const SendResponseScreen({
    super.key,
    required this.sendName,
    required this.message,
  });

  final String sendName;
  final Widget message;

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        primary: false,
        padding: (availWidth < 480)
            ? const EdgeInsets.all(16)
            : EdgeInsets.symmetric(
                horizontal: ((availWidth - 480) / 2) + 16,
                vertical: 16,
              ),
        children: [
          Column(
            children: [
              Icon(
                Iconsax.tick_circle,
                size: 48,
                color: context.successColor,
              ),
              const SizedBox(height: 16),
              Text(
                'Your $sendName was successfully sent.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 32),
          message,
          const SizedBox(height: 32),
          ForegroundFilledBtn(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
