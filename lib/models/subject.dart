import 'activity.dart';

class Subject {
  int id;
  String name;
  String color;
  List<Activity> activities;

  Subject({
    required this.id,
    required this.name,
    required this.color,
    required this.activities,
  });

  Subject copyWith({String? name, String? color, List<Activity>? activities}) {
    return Subject(
      id: id,
      name: name ?? this.name,
      color: color ?? this.color,
      activities: activities ?? this.activities,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'color': color};
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      activities: [],
    );
  }
}
