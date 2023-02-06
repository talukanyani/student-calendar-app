import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sc_app/models/subject.dart';
import 'package:sc_app/models/activity.dart';

class Database {
  final subjectsRef = FirebaseFirestore.instance.collection('subjects');

  Future<List<SubjectModel>> getSyncedData() async {
    List<SubjectModel> syncedData = [];

    final snapshots = await subjectsRef.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
      syncedData.add(
        SubjectModel(
          timeId: doc.data()['timeId'],
          docId: doc.id,
          name: doc.data()['name'],
          color: doc.data()['color'],
          activities: [],
        ),
      );
    }

    for (SubjectModel subject in syncedData) {
      final snapshots =
          await subjectsRef.doc(subject.docId).collection('activities').get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshots.docs) {
        subject.activities.add(
          ActivityModel(
            timeId: doc.data()['timeId'],
            docId: doc.id,
            subjectName: subject.name,
            activity: doc.data()['activity'],
            dateTime: (doc.data()['dateTime'] as Timestamp).toDate(),
          ),
        );
      }
    }

    return syncedData;
  }

  void addSubject(int timeId, String name, String color) {
    subjectsRef.add(
      {'timeId': timeId, 'name': name, 'color': color},
    );
  }

  void deleteSubject(int timeId) {
    subjectsRef.where('timeId', isEqualTo: timeId).get().then((snapshot) {
      final docRef = snapshot.docs.first.reference;

      subjectsRef
          .doc(docRef.id)
          .collection('activities')
          .get()
          .then((snapshot) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      }).then((_) => docRef.delete());
    });
  }

  void editSubject(int timeId, String newName, String newColor) {
    subjectsRef.where('timeId', isEqualTo: timeId).get().then((snapshot) {
      snapshot.docs.first.reference.update({
        'name': newName,
        'color': newColor,
      });
    });
  }

  void addActivity(
    int subjectTimeId,
    int activityTimeId,
    String activity,
    DateTime dateTime,
  ) {
    subjectsRef
        .where('timeId', isEqualTo: subjectTimeId)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference.collection('activities').add({
        'timeId': activityTimeId,
        'activity': activity,
        'dateTime': dateTime,
      });
    });
  }

  void deleteActivity(int subjectTimeId, int activityTimeId) {
    subjectsRef
        .where('timeId', isEqualTo: subjectTimeId)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference
          .collection('activities')
          .where('timeId', isEqualTo: activityTimeId)
          .get()
          .then((snapshot) {
        snapshot.docs.first.reference.delete();
      });
    });
  }

  void editActivity(
    int subjectTimeId,
    int activityTimeId,
    String newActivity,
    DateTime newDateTime,
  ) {
    subjectsRef
        .where('timeId', isEqualTo: subjectTimeId)
        .get()
        .then((snapshot) {
      snapshot.docs.first.reference
          .collection('activities')
          .where('timeId', isEqualTo: activityTimeId)
          .get()
          .then((snapshot) {
        snapshot.docs.first.reference.update({
          'activity': newActivity,
          'dateTime': newDateTime,
        });
      });
    });
  }
}
