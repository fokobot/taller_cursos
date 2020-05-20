import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/person_detail.dart';
import 'package:taller_cursos/services/api.dart';

import '../locator.dart';

class StudentDetailModel extends BaseModel {
  Api _api = locator<Api>();

  PersonDetail student;

  Future getStudent(String user, String token, int studentId) async {
    setState(ViewState.Busy);
    student = await _api.getStudent(user, token, studentId);
    setState(ViewState.Idle);
  }
}
