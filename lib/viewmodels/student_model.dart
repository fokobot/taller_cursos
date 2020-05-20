import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/person.dart';
import 'package:taller_cursos/services/students_service.dart';

import '../locator.dart';

class StudentModel extends BaseModel {
  StudentsService _studentsService = locator<StudentsService>();

  List<Person> get students => _studentsService.students;

  Future getStudents(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _studentsService.getStudents(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}
