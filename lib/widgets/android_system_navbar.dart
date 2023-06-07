import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import '../utils/colors.dart';

class AndroidSystemNavbarStyle extends ConsumerWidget {
  const AndroidSystemNavbarStyle({
    super.key,
    this.color,
    this.iconsBrightness,
    required this.child,
  });

  final Color? color;
  final Brightness? iconsBrightness;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkMode() {
      final themeModeSetting = ref.watch(themeModeProvider);

      if (themeModeSetting == ThemeMode.system) {
        final deviceBrightness =
            SchedulerBinding.instance.platformDispatcher.platformBrightness;
        return deviceBrightness == Brightness.dark;
      } else {
        return (themeModeSetting == ThemeMode.dark);
      }
    }

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: color ?? (isDarkMode() ? black20 : white245),
        systemNavigationBarDividerColor:
            color ?? (isDarkMode() ? black20 : white245),
        systemNavigationBarIconBrightness: iconsBrightness ??
            (isDarkMode() ? Brightness.light : Brightness.dark),
      ),
      child: child,
    );
  }
}
