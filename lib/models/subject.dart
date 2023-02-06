import 'activity.dart';

class SubjectModel {
  int timeId;
  String? docId;
  String name;
  String color;
  List<ActivityModel> activities;

  SubjectModel({
    required this.timeId,
    this.docId,
    required this.name,
    required this.color,
    required this.activities,
  });
}
