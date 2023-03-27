import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/utils/table_colors.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'package:sc_app/widgets/alerts.dart';
import '../modals/table_edit_form.dart';
import 'row.dart';
import 'row_add_button.dart';
import 'popup_menu_item.dart';
import 'oval_text_container.dart';

class SubjectTable extends StatelessWidget {
  const SubjectTable({super.key, required this.subject});

  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    final subjectProvider = Provider.of<SubjectController>(
      context,
      listen: false,
    );
    final activityProvider = Provider.of<ActivityController>(
      context,
      listen: false,
    );
    final activityController = Provider.of<ActivityController>(context);

    final activities = activityController.subjectActivities(subject.id);

    return RectContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Transform(
                transform: Matrix4.rotationZ(-0.05),
                child: OvalTextContainer(
                  text: Text(
                    subject.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: CustomColorScheme.grey4,
                        ),
                  ),
                  color: tableColors[subject.color],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: PopupMenuButton(
                  position: PopupMenuPosition.under,
                  icon: const Icon(Iconsax.more_circle),
                  itemBuilder: (context) => <PopupMenuItem>[
                    popupMenuItem(
                      itemName: 'Edit',
                      itemIcon: Iconsax.edit,
                      onTap: () {
                        Navigator.pop(context);
                        Future.delayed(
                          const Duration(seconds: 1),
                          Show.modal(
                            context,
                            modal: TableEditForm(
                              subjectId: subject.id,
                              subjectName: subject.name,
                              subjectColor: subject.color,
                            ),
                          ),
                        );
                      },
                    ),
                    popupMenuItem(
                      itemName: 'Delete',
                      itemIcon: Iconsax.trash,
                      onTap: () {
                        Navigator.pop(context);
                        Future.delayed(
                          const Duration(seconds: 1),
                          Show.modal(
                            context,
                            modal: Alert(
                              title: const Text('Delete Permanently'),
                              titleIcon: const Icon(
                                FluentIcons.delete_24_filled,
                              ),
                              content: Text(
                                '${subject.name} and its activities will be permanently deleted.',
                              ),
                              actionName: 'Delete',
                              action: () {
                                subjectProvider.removeSubject(subject.id);
                                Show.snackBar(
                                  context,
                                  text: 'One subject was deleted.',
                                  snackBarIcon: SnackBarIcon.done,
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1),
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
            children: [
              headerRow(),
              ...List.generate(
                activities.length,
                (index) => row(
                  subjectId: subject.id,
                  subjectName: subject.name,
                  activity: activities[index],
                  activityProvider: activityProvider,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          RowAddButton(
            subjectTimeId: subject.id,
            subjectName: subject.name,
          ),
        ],
      ),
    );
  }
}
