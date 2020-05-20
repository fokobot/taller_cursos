import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/person.dart';
import 'package:taller_cursos/services/professors_service.dart';

import '../locator.dart';

class ProfessorModel extends BaseModel {
  ProfessorsService _professorsService = locator<ProfessorsService>();

  List<Person> get professors => _professorsService.professors;

  Future getProfessors(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _professorsService.getProfessors(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}
