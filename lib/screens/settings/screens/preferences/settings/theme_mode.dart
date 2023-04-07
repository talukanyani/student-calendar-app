import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/modal.dart';

class ThemeModeSettingModal extends ConsumerWidget {
  const ThemeModeSettingModal({super.key});

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
        visualDensity: const VisualDensity(vertical: -3),
        title: Text(value.title),
      );
    }

    return Modal(
      insetPadding: 32,
      children: [
        option(ThemeMode.light),
        option(ThemeMode.dark),
        option(ThemeMode.system),
      ],
    );
  }
}
