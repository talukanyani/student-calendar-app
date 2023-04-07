import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/local_database.dart';

class DataController extends StateNotifier<List<Subject>> {
  DataController(this.ref) : super([]) {
    _updateWithCachedData().then((_) {
      updateWithSynceddata();
    });
  }

  final Ref ref;

  String? get _userId => ref.read(userIdProvider);
  bool get _isSync => ref.read(dataSyncAndAuthedProvider) ?? false;

  void addSubject(Subject subject) {
    state = [...state, subject];

    LocalDb().cacheData(state);
    if (_isSync) CloudDb().addSubject(subject, userId: _userId);
  }

  void editSubject({required int id, String? newName, String? newColor}) {
    state = [
      for (final subject in state)
        if (subject.id == id)
          subject.copyWith(name: newName, color: newColor)
        else
          subject,
    ];

    LocalDb().cacheData(state);

    if (_isSync) {
      final subject = state.firstWhere((element) => element.id == id);

      CloudDb().editSubject(
        subject.copyWith(name: newName, color: newColor),
        userId: _userId,
      );
    }
  }

  void deleteSubject(int id) {
    state = [
      for (final subject in state)
        if (subject.id != id) subject,
    ];

    LocalDb().cacheData(state);
    if (_isSync) CloudDb().deleteSubject(id, userId: _userId);
  }

  void addActivity(Activity activity) {
    state = [
      for (final subject in state)
        if (subject.id == activity.subjectId)
          subject.copyWith(activities: [...subject.activities, activity])
        else
          subject,
    ];

    LocalDb().cacheData(state);
    if (_isSync) CloudDb().addActivity(activity, userId: _userId);
  }

  void editActivity({
    required int subjectId,
    required int activityId,
    String? newTitle,
    DateTime? newDate,
  }) {
    state = [
      for (final subject in state)
        if (subject.id == subjectId)
          subject.copyWith(
            activities: [
              for (final activity in subject.activities)
                if (activity.id == activityId)
                  activity.copyWith(title: newTitle, date: newDate)
                else
                  activity,
            ],
          )
        else
          subject,
    ];

    LocalDb().cacheData(state);

    if (_isSync) {
      final subject = state.firstWhere((element) => element.id == subjectId);
      final activity = subject.activities.firstWhere((element) {
        return element.id == activityId;
      });

      CloudDb().editActivity(activity, userId: _userId);
    }
  }

  void deleteActivity({required int subjectId, required int activityId}) {
    state = [
      for (final subject in state)
        if (subject.id == subjectId)
          subject.copyWith(
            activities: [
              for (final activity in subject.activities)
                if (activity.id != activityId) activity,
            ],
          )
        else
          subject,
    ];

    LocalDb().cacheData(state);

    if (_isSync) {
      CloudDb().deleteActivity(
        userId: _userId,
        subjectId: subjectId,
        activityId: activityId,
      );
    }
  }

  Future<void> _updateWithCachedData() async {
    final cachedData = await LocalDb().cachedData;
    state = cachedData;
  }

  Future<void> updateWithSynceddata() async {
    if (!_isSync) return;

    final syncedData = await CloudDb().getSyncedData(_userId);

    if (syncedData.isEmpty) {
      CloudDb().addMultipleData(state, userId: _userId);
      return;
    }

    state = syncedData;

    LocalDb().cacheData(state);
  }
}
