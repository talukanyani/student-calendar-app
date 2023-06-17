import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/views/widgets/modal.dart';

class ThemeModeModal extends ConsumerWidget {
  const ThemeModeModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RadioListTile<ThemeMode> option(ThemeMode value) {
      return RadioListTile(
        value: value,
        groupValue: ref.watch(themeModeProvider),
        onChanged: (value) {
          ref.read(themeModeProvider.notifier).set(value ?? ThemeMode.system);
          Navigator.pop(context);
        },
        title: Text(value.title),
        visualDensity: const VisualDensity(vertical: -3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        Text(
          'Choose a theme',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        option(ThemeMode.light),
        option(ThemeMode.dark),
        option(ThemeMode.system),
      ],
    );
  }
}
