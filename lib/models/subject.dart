import 'activity.dart';

class Subject {
  int id;
  String name;
  String colorName;
  List<Activity> activities;

  Subject({
    required this.id,
    required this.name,
    required this.colorName,
    required this.activities,
  });

  Subject copyWith({
    String? name,
    String? colorName,
    List<Activity>? activities,
  }) {
    return Subject(
      id: id,
      name: name ?? this.name,
      colorName: colorName ?? this.colorName,
      activities: activities ?? this.activities,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'colorName': colorName};
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      colorName: json['colorName'],
      activities: [],
    );
  }
}
