import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/controllers/data.dart' show DataAddStatus;
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/alerts.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/input_fields/activity_date_input.dart';
import 'package:sc_app/views/widgets/input_fields/activity_time_input.dart';
import 'package:sc_app/views/widgets/input_fields/activity_title_autocomplete_input.dart';
import 'package:sc_app/views/widgets/rect_container.dart';
import 'package:sc_app/views/widgets/shake_animation.dart';

import 'widgets/form_add_button.dart';
import 'widgets/subject_input.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key, this.subjectId, this.date});

  final int? subjectId;
  final DateTime? date;

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  int activityFormCount = 1;

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Add Activities')),
      body: ListView.builder(
        primary: false,
        padding: (availWidth < 480)
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(horizontal: (availWidth - 480) / 2),
        controller: _scrollController,
        itemCount: (activityFormCount + 1),
        itemBuilder: (context, index) {
          if (index == activityFormCount) {
            return FormAddButton(
              onPressed: (activityFormCount >= 20)
                  ? null
                  : () {
                      setState(() => activityFormCount += 1);
                      _scrollController.animateTo(
                        _scrollController.offset + 500,
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                      );
                    },
            );
          }

          return ActivityForm(subjectId: widget.subjectId, date: widget.date);
        },
      ),
    );
  }
}

class ActivityForm extends ConsumerStatefulWidget {
  const ActivityForm({super.key, required this.subjectId, required this.date});

  final int? subjectId;
  final DateTime? date;

  @override
  ConsumerState<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends ConsumerState<ActivityForm> {
  bool _isAdded = false;
  int? _subjectId;
  String? _title;
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
  void initState() {
    setState(() => _subjectId = widget.subjectId);
    setState(() => _date = widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdded) {
      return RectContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(Iconsax.tick_circle, color: context.successColor),
            const SizedBox(height: 16),
            Text(
              'Activity Added',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: context.successColor,
                  ),
            ),
          ],
        ),
      );
    }

    return RectContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InputFieldLabel(label: 'Subject/Module/Course'),
          ShakeAnimation(
            key: _subjectShakeKey,
            child: SubjectInput(
              initialInput: widget.subjectId,
              onChanged: (value) {
                setState(() => _subjectId = value);
              },
            ),
          ),
          const SizedBox(height: 16),
          const InputFieldLabel(label: 'Activity Title'),
          ShakeAnimation(
            key: _titleShakeKey,
            child: ActivityTitleAutocompleteInput(
              onChanged: (value) {
                setState(() => _title = value);
              },
            ),
          ),
          const SizedBox(height: 8),
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
                        initialInput: widget.date,
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
