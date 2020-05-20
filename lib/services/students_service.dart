import 'package:taller_cursos/data/person.dart';

import '../locator.dart';
import 'api.dart';

class StudentsService {
  Api _api = locator<Api>();

  List<Person> _students = [];
  List<Person> get students => _students;

  Future getStudents(String username, String token) async {
    try {
      _students = await _api.getStudents(username, token);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
