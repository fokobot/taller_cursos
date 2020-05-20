import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/data/course_detail.dart';
import 'package:taller_cursos/services/api.dart';

import '../locator.dart';

class CourseDetailModel extends BaseModel {
  Api _api = locator<Api>();

  CourseDetail courseDetail;

  Future getCourse(
    String user, String token, int courseId) async {
    setState(ViewState.Busy);
    courseDetail = await _api.getCourse(user, token, courseId);
    setState(ViewState.Idle);
  }

  Future addStudent(String user, String token, int courseId) async {
    setState(ViewState.Busy);
    try {
      await _api.addStudent(user, token, courseId);
      courseDetail = await _api.getCourse(user, token, courseId);
      setState(ViewState.Idle);
      return Future.value(true);
    } catch (err) {
      setState(ViewState.Idle);
      return Future.error(err.toString());
    }
  }

}