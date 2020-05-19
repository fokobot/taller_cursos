import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/person_detail.dart';
import 'package:taller_cursos/services/api.dart';

import '../locator.dart';

class ProfessorDetailModel extends BaseModel {
  Api _api = locator<Api>();

  PersonDetail professor;

  Future getProfessor(String user, String token, int professorId) async {
    setState(ViewState.Busy);
    professor = await _api.getProfessor(user, token, professorId);
    setState(ViewState.Idle);
  }
}
