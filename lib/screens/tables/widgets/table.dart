import 'package:flutter/material.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'row.dart';
import 'activity_add_button.dart';
import 'subject_popup_menu.dart';
import 'oval_text_container.dart';

class SubjectTable extends StatelessWidget {
  const SubjectTable({super.key, required this.subject});

  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return RectContainer(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform(
                transform: Matrix4.rotationZ(-0.05),
                child: OvalTextContainer(
                  text: Text(
                    subject.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: context.grey4,
                        ),
                  ),
                  color: context.subjectColors[subject.colorName],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: SubjectPopupMenuButton(subject: subject),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1),
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
            children: [
              headerRow(),
              ...List.generate(
                subject.activities.length,
                (index) => row(activity: subject.activities[index]),
              ),
            ],
          ),
          const ActivityAddButton(),
        ],
      ),
    );
  }
}
