class ActivityModel {
  int id;
  int subjectId;
  String subjectName;
  String activity;
  DateTime dateTime;

  ActivityModel({
    required this.id,
    required this.subjectId,
    required this.subjectName,
    required this.activity,
    required this.dateTime,
  });

  Map<String, dynamic> toEncodableJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'activity': activity,
      'dateTime': dateTime.toString(),
    };
  }

  factory ActivityModel.fromEncodableJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      subjectId: json['subjectId'],
      subjectName: json['subjectName'],
      activity: json['activity'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
