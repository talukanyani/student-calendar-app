import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sc_app/models/subject.dart';

class LocalDb {
  static Future<File> _file(String filename) async {
    var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/$filename');

    if (!file.existsSync()) await file.create();

    return file;
  }

  final _subjectsFile = _file('subjects.json');

  Future<List<SubjectModel>> get cachedSubjects async {
    var file = await _subjectsFile;
    var body = await file.readAsString();

    if (body.isEmpty) return [];

    var maps = jsonDecode(body);

    List<SubjectModel> subjects = [];

    for (var map in maps) {
      subjects.add(SubjectModel.fromEncodableJson(map));
    }

    return subjects;
  }

  Future<void> cacheSubjects(List<SubjectModel> subjects) async {
    var file = await _subjectsFile;

    List<Map<String, dynamic>> maps = [];

    for (var subject in subjects) {
      maps.add(subject.toEncodableJson());
    }

    file.writeAsString(jsonEncode(maps));
  }
}
