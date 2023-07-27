import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:sc_app/views/screens/calendar/calendar.dart';
import 'package:sc_app/views/screens/settings/settings.dart';
import 'package:sc_app/views/screens/tables/tables.dart';
import 'package:sc_app/views/themes/color_scheme.dart';

class SideNavBar extends StatelessWidget {
  const SideNavBar({
    super.key,
    required this.screenIndex,
    required this.isVisible,
    this.backgroundColor,
    required this.child,
  });

  final int screenIndex;
  final bool isVisible;
  final Color? backgroundColor;
  final Widget child;

  void pushPrimaryScreen(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isVisible
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    primary: false,
                    child: Container(
                      width: 64,
                      height: constraints.maxHeight,
                      constraints: const BoxConstraints(minHeight: 300),
                      color: backgroundColor ??
                          Theme.of(context).colorScheme.background,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          Material(
                            type: MaterialType.transparency,
                            child: ListTile(
                              iconColor: context.grey4,
                              leading: (screenIndex == 0)
                                  ? const Icon(FluentIcons.home_24_filled)
                                  : const Icon(FluentIcons.home_24_regular),
                              onTap: () => Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              ),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: ListTile(
                              iconColor: context.grey4,
                              leading: (screenIndex == 1)
                                  ? const Icon(FluentIcons.table_24_filled)
                                  : const Icon(FluentIcons.table_24_regular),
                              onTap: () => pushPrimaryScreen(
                                context,
                                const TablesScreen(),
                              ),
                            ),
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: ListTile(
                              iconColor: context.grey4,
                              leading: (screenIndex == 2)
                                  ? const Icon(
                                      FluentIcons.calendar_ltr_24_filled)
                                  : const Icon(
                                      FluentIcons.calendar_ltr_24_regular),
                              onTap: () => pushPrimaryScreen(
                                context,
                                const CalendarScreen(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Spacer(),
                          Material(
                            type: MaterialType.transparency,
                            child: ListTile(
                              iconColor: context.grey4,
                              leading:
                                  const Icon(FluentIcons.settings_24_regular),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
        Expanded(child: child),
      ],
    );
  }
}
