import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sc_app/models/subject.dart';

class LocalDatabase {
  Future<List<SubjectModel>> get cachedSubjects async {
    var file = await _subjectsFile();
    var body = await file.readAsString();

    if (body.isEmpty) return [];

    var maps = jsonDecode(body);

    List<SubjectModel> data = [];

    for (var map in maps) {
      data.add(SubjectModel.fromEncodableJson(map));
    }

    return data;
  }

  Future<void> cacheSubjects(List<SubjectModel> subjects) async {
    var file = await _subjectsFile();
    List<Map<String, dynamic>> subjectsMaps = [];

    for (var subject in subjects) {
      subjectsMaps.add(subject.toEncodableJson());
    }

    file.writeAsString(jsonEncode(subjectsMaps));
  }

  Future<Map<String, dynamic>> get cachedSettings async {
    var file = await _settingsFile();
    var body = await file.readAsString();

    if (body.isEmpty) return {};

    return jsonDecode(body);
  }

  Future<void> cacheSettings(Map<String, dynamic> settingsMap) async {
    var file = await _settingsFile();
    file.writeAsString(jsonEncode(settingsMap));
  }

  Future<File> _subjectsFile() => _file('subjects.json');
  Future<File> _settingsFile() => _file('settings.json');

  Future<File> _file(String filename) async {
    var directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/$filename');

    if (!file.existsSync()) await file.create();

    return file;
  }
}