import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/input_field_label.dart';
import 'package:sc_app/widgets/shake_animation.dart';
import 'package:sc_app/widgets/rect_container.dart';
import 'package:sc_app/widgets/input_fields/activity_description_input.dart';
import 'package:sc_app/widgets/input_fields/activity_date_input.dart';
import 'package:sc_app/widgets/input_fields/activity_time_input.dart';
import 'package:sc_app/widgets/input_fields/activity_title_autocomplete_input.dart';
import 'widgets/form_add_button.dart';
import 'widgets/subject_input.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  int activityFormCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Activities')),
      body: ListView.builder(
        primary: false,
        itemCount: (activityFormCount + 1),
        itemBuilder: (context, index) {
          if (index == activityFormCount) {
            return FormAddButton(
              onPressed: (activityFormCount >= 20)
                  ? null
                  : () => setState(() => activityFormCount += 1),
            );
          }

          return const ActivityForm();
        },
      ),
    );
  }
}

class ActivityForm extends ConsumerStatefulWidget {
  const ActivityForm({super.key});

  @override
  ConsumerState<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends ConsumerState<ActivityForm> {
  bool _isAdded = false;
  int? _subjectId;
  String? _title;
  String? _description;
  DateTime? _date;
  TimeOfDay? _time;

  final _subjectShakeKey = GlobalKey<ShakeAnimationState>();
  final _titleShakeKey = GlobalKey<ShakeAnimationState>();
  final _dateShakeKey = GlobalKey<ShakeAnimationState>();
  final _timeShakeKey = GlobalKey<ShakeAnimationState>();

  bool validateForm() {
    final isSubjectSelected = _subjectId != null;
    final isTitleWritten = _title != null && _title!.isNotEmpty;
    final isDatePicked = _date != null;
    final isTimePicked = _time != null;

    if (!isSubjectSelected) _subjectShakeKey.currentState?.shake();
    if (!isTitleWritten) _titleShakeKey.currentState?.shake();
    if (!isDatePicked) _dateShakeKey.currentState?.shake();
    if (!isTimePicked) _timeShakeKey.currentState?.shake();

    return isSubjectSelected && isTitleWritten && isDatePicked && isTimePicked;
  }

  void _addActivity(BuildContext context) {
    ref
        .watch(dataProvider.notifier)
        .addActivity(
          Activity(
            id: DateTime.now().millisecondsSinceEpoch,
            subjectId: _subjectId!,
            title: _title!,
            description: _description,
            dateTime: DateTime(_date!.year, _date!.month, _date!.day,
                _time!.hour, _time!.minute),
          ),
        )
        .then((value) {
      if (value == DataAddStatus.limitError) {
        showDialog(
          context: context,
          builder: (context) => const InfoAlert(
            title: Text('Activities Limit Reached'),
            content: Text(
              'You have reached maximum number of activities. '
              'Delete old activities.',
            ),
          ),
        );
      } else {
        setState(() => _isAdded = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdded) {
      return RectContainer(
        child: Row(
          children: [
            const Spacer(flex: 2),
            Icon(Iconsax.tick_circle, color: context.successColor),
            const Spacer(),
            Expanded(
              child: Text(
                'Activity Added',
                style: TextStyle(color: context.successColor),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      );
    }

    return RectContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InputFieldLabel(label: 'Subject'),
          ShakeAnimation(
            key: _subjectShakeKey,
            child: SubjectInput(
              onChanged: (value) {
                setState(() => _subjectId = value);
              },
            ),
          ),
          const SizedBox(height: 16),
          const InputFieldLabel(label: 'Title'),
          ShakeAnimation(
            key: _titleShakeKey,
            child: ActivityTitleAutocompleteInput(
              onChanged: (value) {
                setState(() => _title = value);
              },
            ),
          ),
          const SizedBox(height: 16),
          const InputFieldLabel(label: 'Description (optional)'),
          ActivityDescriptionInput(
            onChanged: (value) {
              setState(() => _description = value);
            },
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputFieldLabel(label: 'Date'),
                    ShakeAnimation(
                      key: _dateShakeKey,
                      child: ActivityDateInput(
                        onChanged: (value) {
                          setState(() => _date = value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputFieldLabel(label: 'Time'),
                    ShakeAnimation(
                      key: _timeShakeKey,
                      child: ActivityTimeInput(
                        onChanged: (value) {
                          setState(() => _time = value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryFilledBtn(
              onPressed: () {
                if (validateForm()) _addActivity(context);
              },
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}
