class ActivityModel {
  int timeId;
  String? docId;
  String subjectName;
  String activity;
  DateTime dateTime;

  ActivityModel({
    required this.timeId,
    this.docId,
    required this.subjectName,
    required this.activity,
    required this.dateTime,
  });
}
