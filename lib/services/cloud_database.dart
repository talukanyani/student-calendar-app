import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/activity.dart';
import 'authentication.dart';

class CloudDatabase {
  CloudDatabase() {
    Auth().userChanges.listen((user) {
      _user = user;
    });
  }

  static User? _user = Auth().currentUser;

  static final _db = FirebaseFirestore.instance;
  static final _userDb = _db.collection('users').doc(_user?.uid ?? 'none');

  final _subjectsCollection = _userDb.collection('subjects');
  final _settingsCollection = _userDb.collection('settings');
  final _helpsCollection = _db.collection('helps');
  final _bugReportsCollection = _db.collection('bug_reports');
  final _suggestionsCollection = _db.collection('suggestions');

  Query<Map<String, dynamic>> _subjectQuery(int id) {
    return _subjectsCollection.where('id', isEqualTo: id);
  }

  Future<List<SubjectModel>> get syncedSubjects async {
    List<SubjectModel> subjects = [];

    var subjectsSnapshot = await _subjectsCollection.get();

    for (var subjectDoc in subjectsSnapshot.docs) {
      List<ActivityModel> activities = [];

      var activitiesCollection =
          _subjectsCollection.doc(subjectDoc.id).collection('activities');
      var activitiesSnapshot = await activitiesCollection.get();

      for (var activityDoc in activitiesSnapshot.docs) {
        activities.add(
          ActivityModel(
            id: activityDoc.data()['id'],
            subjectId: activityDoc.data()['subjectId'],
            subjectName: subjectDoc.data()['name'],
            activity: activityDoc.data()['activity'],
            dateTime: (activityDoc.data()['dateTime'] as Timestamp).toDate(),
          ),
        );
      }

      subjects.add(
        SubjectModel(
          id: subjectDoc.data()['id'],
          name: subjectDoc.data()['name'],
          color: subjectDoc.data()['color'],
          activities: activities,
        ),
      );
    }

    return subjects;
  }

  Future<Map<String, dynamic>> get syncedSettings async {
    final snapshot = await _settingsCollection.get();
    if (snapshot.docs.isEmpty) return {};
    return snapshot.docs.first.data();
  }

  void addSubject(int id, String name, String color) {
    _subjectsCollection.add(
      {'id': id, 'name': name, 'color': color},
    );
  }

  void deleteSubject(int id) {
    _subjectQuery(id).get().then((snapshot) {
      var docRef = snapshot.docs.first.reference;
      var activitiesCollection =
          _subjectsCollection.doc(docRef.id).collection('activities');

      activitiesCollection.get().then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      docRef.delete();
    });
  }

  void editSubject(int id, String newName, String newColor) {
    _subjectQuery(id).get().then((snapshot) {
      snapshot.docs.first.reference.update({
        'name': newName,
        'color': newColor,
      });
    });
  }

  void addActivity(
    int subjectId,
    int activityId,
    String activity,
    DateTime dateTime,
  ) {
    _subjectQuery(subjectId).get().then((snapshot) {
      snapshot.docs.first.reference.collection('activities').add({
        'id': activityId,
        'subjectId': subjectId,
        'activity': activity,
        'dateTime': dateTime,
      });
    });
  }

  void deleteActivity(int subjectId, int activityId) {
    _subjectQuery(subjectId).get().then((snapshot) {
      var collection = snapshot.docs.first.reference.collection('activities');
      var query = collection.where('id', isEqualTo: activityId);

      query.get().then((snapshot) {
        snapshot.docs.first.reference.delete();
      });
    });
  }

  void editActivity(
    int subjectId,
    int activityId,
    String newActivity,
    DateTime newDateTime,
  ) {
    _subjectQuery(subjectId).get().then((snapshot) {
      var collection = snapshot.docs.first.reference.collection('activities');
      var query = collection.where('id', isEqualTo: activityId);

      query.get().then((snapshot) {
        snapshot.docs.first.reference.update({
          'activity': newActivity,
          'dateTime': newDateTime,
        });
      });
    });
  }

  void addMultipleSubjets(List<SubjectModel> data) {
    for (var subject in data) {
      _subjectsCollection.add({
        'id': subject.id,
        'name': subject.name,
        'color': subject.color,
      }).then((subjectDocRef) {
        for (var activity in subject.activities) {
          subjectDocRef.collection('activities').add({
            'id': activity.id,
            'subjectId': subject.id,
            'activity': activity.activity,
            'dateTime': activity.dateTime,
          });
        }
      });
    }
  }

  void deleteAllSujects() {
    _subjectsCollection.get().then((subjectsSnapshot) {
      for (var subjectDoc in subjectsSnapshot.docs) {
        var activitiesCollection =
            subjectDoc.reference.collection('activities');

        activitiesCollection.get().then((activitiesSnapShot) {
          for (var activityDoc in activitiesSnapShot.docs) {
            activityDoc.reference.delete();
          }
        });

        subjectDoc.reference.delete();
      }
    });
  }

  void syncSettings(Map<String, dynamic> settingsMap) {
    _settingsCollection.get().then((snapshot) {
      var docs = snapshot.docs;

      if (docs.isEmpty) {
        _settingsCollection.add(settingsMap);
      } else {
        docs.first.reference.update(settingsMap);
      }
    });
  }

  void unSyncSettings() {
    _settingsCollection.get().then((snapshot) {
      snapshot.docs.first.reference.delete();
    });
  }

  void sendHelp(String text) {
    _helpsCollection.add({
      'userId': _user?.uid,
      'userName': _user?.displayName,
      'userEmail': _user?.email,
      'message': text,
    });
  }

  void sendBugReport(String text) {
    _bugReportsCollection.add({
      'userId': _user?.uid,
      'userName': _user?.displayName,
      'userEmail': _user?.email,
      'message': text,
    });
  }

  void sendSuggestion(String text) {
    _suggestionsCollection.add({
      'userId': _user?.uid,
      'userName': _user?.displayName,
      'userEmail': _user?.email,
      'message': text,
    });
  }
}
