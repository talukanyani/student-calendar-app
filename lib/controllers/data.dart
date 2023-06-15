import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/services/local_database.dart';

enum DataAddStatus {
  done,
  limitError,
}

class DataController extends StateNotifier<List<Subject>> {
  DataController(this.ref) : super([]) {
    _updateWithCachedData().then((_) {
      updateWithSyncedData();
    });
  }

  final Ref ref;

  String? get _userId => ref.read(userProvider)?.uid;

  bool get _isSync => ref.watch(dataSyncProvider) && (_userId != null);

  Future<DataAddStatus> addSubject(Subject subject) async {
    if (state.length >= 20) return DataAddStatus.limitError;

    state = [...state, subject];

    await LocalDb().cacheData(state);
    if (_isSync) CloudDb().addSubject(subject, userId: _userId);

    return DataAddStatus.done;
  }

  void editSubject({required int id, String? newName, String? newColorName}) {
    state = [
      for (final subject in state)
        if (subject.id == id)
          subject.copyWith(name: newName, colorName: newColorName)
        else
          subject,
    ];

    LocalDb().cacheData(state);

    if (_isSync) {
      final subject = state.firstWhere((element) => element.id == id);

      CloudDb().editSubject(
        subject.copyWith(name: newName, colorName: newColorName),
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

  Future<DataAddStatus> addActivity(Activity activity) async {
    if (_activitiesCount >= 1000) return DataAddStatus.limitError;

    state = [
      for (final subject in state)
        if (subject.id == activity.subjectId)
          subject.copyWith(activities: [...subject.activities, activity])
        else
          subject,
    ];

    await LocalDb().cacheData(state);
    if (_isSync) CloudDb().addActivity(activity, userId: _userId);

    return DataAddStatus.done;
  }

  void editActivity({
    required int subjectId,
    required int activityId,
    String? newTitle,
    String? newDescription,
    DateTime? newDateTime,
  }) {
    state = [
      for (final subject in state)
        if (subject.id == subjectId)
          subject.copyWith(
            activities: [
              for (final activity in subject.activities)
                if (activity.id == activityId)
                  activity.copyWith(
                    title: newTitle,
                    description: newDescription,
                    dateTime: newDateTime,
                  )
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

  int get _activitiesCount {
    int count = 0;

    for (final subject in state) {
      count += subject.activities.length;
    }

    return count;
  }

  Future<void> _updateWithCachedData() async {
    final cachedData = await LocalDb().cachedData;
    state = cachedData;
  }

  Future<void> updateWithSyncedData() async {
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
