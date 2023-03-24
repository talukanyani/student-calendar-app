import 'activity.dart';

class SubjectModel {
  int id;
  String name;
  String color;
  List<ActivityModel> activities;

  SubjectModel({
    required this.id,
    required this.name,
    required this.color,
    required this.activities,
  });

  Map<String, dynamic> toEncodableJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'activities': List.generate(activities.length, (index) {
        return activities.elementAt(index).toEncodableJson();
      }),
    };
  }

  factory SubjectModel.fromEncodableJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      activities: List.generate(json['activities'].length, (index) {
        return ActivityModel.fromEncodableJson(
          json['activities'].elementAt(index),
        );
      }),
    );
  }
}
