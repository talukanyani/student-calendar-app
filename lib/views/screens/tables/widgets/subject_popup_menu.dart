import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/views/modals/delete_subject.dart';
import 'package:sc_app/views/modals/edit_subject.dart';
import 'package:sc_app/views/widgets/popup_menu_tile.dart';

class SubjectPopupMenuButton extends ConsumerWidget {
  const SubjectPopupMenuButton({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      icon: const Icon(Iconsax.more_circle),
      tooltip: 'more actions',
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: popupMenuTile(
            title: 'Edit',
            icon: FluentIcons.edit_24_regular,
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: popupMenuTile(
            title: 'Delete',
            icon: FluentIcons.delete_24_regular,
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            showDialog(
              context: context,
              builder: (context) => EditSubjectModal(subject: subject),
            );
            break;
          case 2:
            showDialog(
              context: context,
              builder: (context) => DeleteSubjectModal(subject: subject),
            );
            break;
        }
      },
    );
  }
}
