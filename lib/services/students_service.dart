import 'package:taller_cursos/data/person.dart';

import '../locator.dart';
import 'api.dart';

class StudentsService {
  Api _api = locator<Api>();

  String _user;
  String _token;
  List<Person> _students = [];
  List<Person> get students => _students;

  Future getStudents(String username, String token) async {
    _user = username;
    _token = token;
    try {
      _students = await _api.getStudents(username, token);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
