import 'package:taller_cursos/data/course.dart';
import 'package:taller_cursos/services/api.dart';

import '../locator.dart';

class CourseService {
  Api _api = locator<Api>();

  String _user;
  String _token;
  List<Course> _couses = [];
  List<Course> get couses => _couses;

  Future getCourses(String username, String token) async {
    _user = username;
    _token = token;
    try {
      _couses = await _api.getCourses(username, token);
    } catch (err) {
      print('service getCourses ${err.toString()}');
      return Future.error(err.toString());
    }
  }

  Future addCourse() async {
    try {
      Course course = await _api.addCourseService(_user, _token);
      _couses.add(course);
    } catch (err) {
      print('service addCourse ${err.toString()}');
      return Future.error(err.toString());
    }
  }
}