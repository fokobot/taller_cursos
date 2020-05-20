import 'package:taller_cursos/data/person.dart';

import '../locator.dart';
import 'api.dart';

class ProfessorsService {
  Api _api = locator<Api>();

  List<Person> _professors = [];
  List<Person> get professors => _professors;

  Future getProfessors(String username, String token) async {
    try {
      _professors = await _api.getProfessors(username, token);
    } catch (err) {
      return Future.error(err.toString());
    }
  }
}
