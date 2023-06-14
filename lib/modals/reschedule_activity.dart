import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/input_field_label.dart';
import 'package:sc_app/widgets/input_fields/activity_date_input.dart';
import 'package:sc_app/widgets/input_fields/activity_time_input.dart';
import 'package:sc_app/widgets/shake_animation.dart';
import 'widgets/modal_form.dart';

class RescheduleActivityModal extends ConsumerStatefulWidget {
  const RescheduleActivityModal({super.key, required this.activity});

  final Activity activity;

  @override
  ConsumerState<RescheduleActivityModal> createState() =>
      _RescheduleActivityModalState();
}

class _RescheduleActivityModalState
    extends ConsumerState<RescheduleActivityModal> {
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  final _dateShakeKey = GlobalKey<ShakeAnimationState>();
  final _timeShakeKey = GlobalKey<ShakeAnimationState>();

  DateTime get _currentActivityDate => DateTime(
        widget.activity.dateTime.year,
        widget.activity.dateTime.month,
        widget.activity.dateTime.day,
      );

  TimeOfDay get _currentActivityTime => TimeOfDay(
        hour: widget.activity.dateTime.hour,
        minute: widget.activity.dateTime.minute,
      );

  @override
  void initState() {
    _date = _currentActivityDate;
    _time = _currentActivityTime;
    super.initState();
  }

  void _rescheduleActivity({required void Function() onDone}) {
    ref.read(dataProvider.notifier).editActivity(
          subjectId: widget.activity.subjectId,
          activityId: widget.activity.id,
          newDateTime: DateTime(
              _date.year, _date.month, _date.day, _time.hour, _time.minute),
        );

    onDone();
  }

  @override
  Widget build(BuildContext context) {
    return ModalForm(
      title: 'Reschedule Activity',
      inputFields: [
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
                      initialInput: _currentActivityDate,
                      onChanged: (value) {
                        setState(() => _date = value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InputFieldLabel(label: 'Time'),
                  ShakeAnimation(
                    key: _timeShakeKey,
                    child: ActivityTimeInput(
                      initialInput: _currentActivityTime,
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
      ],
      submitButtonText: 'Save',
      onSubmit: () {
        if (_date == _currentActivityDate && _time == _currentActivityTime) {
          Navigator.pop(context);
        } else {
          _rescheduleActivity(
            onDone: () {
              Navigator.pop(context);
              Helpers.showSnackBar(
                context,
                text: '${widget.activity.title} was successfully rescheduled',
                snackBarIcon: SnackBarIcon.done,
              );
            },
          );
        }
      },
    );
  }
}
