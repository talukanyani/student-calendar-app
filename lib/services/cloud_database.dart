import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/activity.dart';

class CloudDb {
  static final _db = FirebaseFirestore.instance;

  final _helpsCollection = _db.collection('helps');
  final _bugReportsCollection = _db.collection('bug_reports');
  final _suggestionsCollection = _db.collection('suggestions');

  CollectionReference<Map<String, dynamic>> _subjectsCollection(
      String? userId) {
    var userDoc = _db.collection('users').doc(userId ?? 'error');
    return userDoc.collection('subjects');
  }

  Future<DocumentReference<Map<String, dynamic>>> _subjectDoc(
      {required String? userId, required int subjectId}) async {
    var query = _subjectsCollection(userId).where('id', isEqualTo: subjectId);
    var snapshot = await query.get();

    return snapshot.docs.first.reference;
  }

  Future<DocumentReference<Map<String, dynamic>>> _activityDoc(
      {required String? userId,
      required int subjectId,
      required int activityId}) async {
    var subjectDoc = await _subjectDoc(userId: userId, subjectId: subjectId);
    var activitiesCollection = subjectDoc.collection('activities');

    var query = activitiesCollection.where('id', isEqualTo: activityId);
    var snapshot = await query.get();

    return snapshot.docs.first.reference;
  }

  Future<List<Subject>> getSyncedData(String? userId) async {
    var subjectsSnapshot = await _subjectsCollection(userId).get();

    List<Subject> subjects = [];

    for (var subjectDoc in subjectsSnapshot.docs) {
      var activitiesSnapshot =
          await subjectDoc.reference.collection('activities').get();

      List<Activity> activities = [];

      for (var activityDoc in activitiesSnapshot.docs) {
        activities.add(Activity.fromJson(activityDoc.data()));
      }

      subjects.add(
        Subject(
          id: subjectDoc.data()['id'],
          name: subjectDoc.data()['name'],
          color: subjectDoc.data()['color'],
          activities: activities,
        ),
      );
    }

    return subjects;
  }

  Future<void> addSubject(Subject subject, {required String? userId}) async {
    await _subjectsCollection(userId).add(subject.toJson());
  }

  Future<void> editSubject(Subject subject, {required String? userId}) async {
    var doc = await _subjectDoc(userId: userId, subjectId: subject.id);
    await doc.update(subject.toJson());
  }

  Future<void> deleteSubject(int id, {required String? userId}) async {
    var subjectDoc = await _subjectDoc(userId: userId, subjectId: id);
    var activitiesSnapShot = await subjectDoc.collection('activities').get();

    for (var activityDoc in activitiesSnapShot.docs) {
      await activityDoc.reference.delete();
    }

    await subjectDoc.delete();
  }

  Future<void> addActivity(Activity activity, {required String? userId}) async {
    var subjectDoc =
        await _subjectDoc(userId: userId, subjectId: activity.subjectId);
    var activitiesCollection = subjectDoc.collection('activities');

    await activitiesCollection.add(activity.toJson());
  }

  Future<void> editActivity(
    Activity activity, {
    required String? userId,
  }) async {
    var doc = await _activityDoc(
      userId: userId,
      subjectId: activity.subjectId,
      activityId: activity.id,
    );

    await doc.update(activity.toJson());
  }

  Future<void> deleteActivity({
    required String? userId,
    required int subjectId,
    required int activityId,
  }) async {
    var doc = await _activityDoc(
      userId: userId,
      subjectId: subjectId,
      activityId: activityId,
    );

    await doc.delete();
  }

  Future<void> addMultipleData(
    List<Subject> subjects, {
    required String? userId,
  }) async {
    for (var subject in subjects) {
      await _subjectsCollection(userId)
          .add(subject.toJson())
          .then((subjectDoc) async {
        for (var activity in subject.activities) {
          await subjectDoc.collection('activities').add(activity.toJson());
        }
      });
    }
  }

  Future<void> deleteAllData(String? userId) async {
    var subjectsSnapshot = await _subjectsCollection(userId).get();

    for (var subjectDoc in subjectsSnapshot.docs) {
      var activitiesSnapshot =
          await subjectDoc.reference.collection('activities').get();

      for (var activityDoc in activitiesSnapshot.docs) {
        activityDoc.reference.delete();
      }

      subjectDoc.reference.delete();
    }
  }

  Future<void> sendHelp(String text, {required User? user}) async {
    if (user == null) return;

    await _helpsCollection.add({
      'userId': user.uid,
      'userName': user.displayName,
      'userEmail': user.email,
      'message': text,
    });
  }

  Future<void> sendBugReport(String text, {required User? user}) async {
    if (user == null) return;

    await _bugReportsCollection.add({
      'userId': user.uid,
      'userName': user.displayName,
      'userEmail': user.email,
      'message': text,
    });
  }

  Future<void> sendSuggestion(String text, {required User? user}) async {
    if (user == null) return;

    await _suggestionsCollection.add({
      'userId': user.uid,
      'userName': user.displayName,
      'userEmail': user.email,
      'message': text,
    });
  }
}
