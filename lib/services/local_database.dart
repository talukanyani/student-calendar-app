import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

class LocalDb {
  static Future<File> _file(String filename) async {
    var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/$filename');

    if (!file.existsSync()) await file.create();

    return file;
  }

  final _dataFile = _file('data.json');

  Future<List<Subject>> get cachedData async {
    final file = await _dataFile;
    var body = await file.readAsString();

    if (body.isEmpty) return [];

    var maps = jsonDecode(body);

    List<Subject> subjects = [];

    for (var map in maps) {
      final subject = Subject.fromJson(map);
      final activities = List.generate(
        map['activities'].length,
        (index) => Activity.fromJson(map['activities'].elementAt(index)),
      );

      subject.activities.addAll(activities);

      subjects.add(subject);
    }

    return subjects;
  }

  Future<void> cacheData(List<Subject> subjects) async {
    final file = await _dataFile;

    List<Map<String, dynamic>> maps = [];

    for (var subject in subjects) {
      final subjectMap = subject.toJson();
      final activitiesMap = {
        'activities': List.generate(
          subject.activities.length,
          (index) => subject.activities.elementAt(index).toJson(),
        )
      };

      subjectMap.addEntries(activitiesMap.entries);

      maps.add(subjectMap);
    }

    file.writeAsString(jsonEncode(maps));
  }
}
