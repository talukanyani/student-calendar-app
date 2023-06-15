import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedDayState extends StateNotifier<DateTime> {
  SelectedDayState() : super(DateTime.now());

  void change(DateTime date) {
    state = date;
  }
}

final selectedDayProvider =
    StateNotifierProvider<SelectedDayState, DateTime>((ref) {
  return SelectedDayState();
});
