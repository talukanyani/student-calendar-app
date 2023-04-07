class Activity {
  int id;
  int subjectId;
  String subjectName;
  String title;
  DateTime date;

  Activity({
    required this.id,
    required this.subjectId,
    required this.subjectName,
    required this.title,
    required this.date,
  });

  Activity copyWith({String? title, DateTime? date}) {
    return Activity(
      id: id,
      subjectId: subjectId,
      subjectName: subjectName,
      title: title ?? this.title,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'subjectName': subjectName,
      'title': title,
      'date': date.toString(),
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      subjectId: json['subjectId'],
      subjectName: json['subjectName'],
      title: json['title'],
      date: DateTime.parse(json['date']),
    );
  }
}
