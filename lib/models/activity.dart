class Activity {
  int id;
  int subjectId;
  String title;
  String? description;
  DateTime dateTime;

  Activity({
    required this.id,
    required this.subjectId,
    required this.title,
    this.description,
    required this.dateTime,
  });

  Activity copyWith({
    int? subjectId,
    String? title,
    String? description,
    DateTime? dateTime,
  }) {
    return Activity(
      id: id,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'title': title,
      'description': description,
      'dateTime': dateTime.toString(),
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      subjectId: json['subjectId'],
      title: json['title'],
      description: json['description'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
