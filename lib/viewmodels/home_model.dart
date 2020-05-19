import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/course.dart';
import 'package:taller_cursos/services/courses_service.dart';

import '../locator.dart';

class HomeModel extends BaseModel {
  CourseService _couseService = locator<CourseService>();

  List<Course> get courses => _couseService.couses;
  bool dataAvailable = true;

  Future getCourses(String user, String token) async {
    setState(ViewState.Busy);
    try {
      await _couseService.getCourses(user, token);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel getCourses ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }

   
  }

  Future addCourse() async {
    setState(ViewState.Busy);
  try {
      await _couseService.addCourse();
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      print('homemodel addCourse ${err.toString()}');
       setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }
}