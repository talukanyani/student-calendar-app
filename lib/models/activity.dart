class Activity {
  int id;
  int subjectId;
  String title;
  DateTime dateTime;

  Activity({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.dateTime,
  });

  Activity copyWith({int? subjectId, String? title, DateTime? dateTime}) {
    return Activity(
      id: id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'title': title,
      'dateTime': dateTime.toString(),
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      subjectId: json['subjectId'],
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
