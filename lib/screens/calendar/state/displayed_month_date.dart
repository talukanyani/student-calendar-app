import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayedMonthDateState extends StateNotifier<DateTime> {
  DisplayedMonthDateState() : super(DateTime.now());

  void change(DateTime date) {
    state = date;
  }
}

final displayedMonthDateProvider =
    StateNotifierProvider<DisplayedMonthDateState, DateTime>((ref) {
  return DisplayedMonthDateState();
});
