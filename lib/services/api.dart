import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:taller_cursos/data/course.dart';
import 'package:taller_cursos/data/course_detail.dart';
import 'package:taller_cursos/data/person.dart';
import 'package:taller_cursos/data/person_detail.dart';
import 'package:taller_cursos/data/user.dart';

class Api {
  static const String baseUrl = 'https://movil-api.herokuapp.com';

  var client = new http.Client();

  Future<User> getUserProfile({String email, String password}) async {
    final http.Response response = await http.post(
      '$baseUrl/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      return Future.error(body['error']);
    }
  }

  Future<List<Course>> getCourses(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/courses',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    print(
        'showCoursesService username $username token $token => ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Course> couseList = [];
      for (Map i in data) {
        couseList.add(Course.fromJson(i));
      }
      print('showCoursesService length ${couseList.length}');
      return couseList;
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<CourseDetail> getCourse(
      String username, String token, int courseId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/courses/$courseId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      return CourseDetail.fromJson(json.decode(response.body));
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<Course> addCourseService(String username, String token) async {
    final http.Response response = await http.post(
      baseUrl + '/' + username + '/courses',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      return Course.fromJson(json.decode(response.body));
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      String error = body['error'];
      return Future.error(error);
    }
  }

  Future<List<Person>> getStudents(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/students',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Person> studentsList = [];
      for (Map i in data) {
        studentsList.add(Person.fromJson(i));
      }
      return studentsList;
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<List<Person>> getProfessors(String username, String token) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/professors',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Person> professorsList = [];
      for (Map i in data) {
        professorsList.add(Person.fromJson(i));
      }
      return professorsList;
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<PersonDetail> getProfessor(
      String username, String token, int professorId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/professors/$professorId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      return PersonDetail.fromJson(json.decode(response.body));
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<PersonDetail> getStudent(
      String username, String token, int studentId) async {
    Uri uri = Uri.https(
      "movil-api.herokuapp.com",
      '$username/students/$studentId',
    );
    final http.Response response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
    );
    if (response.statusCode == 200) {
      return PersonDetail.fromJson(json.decode(response.body));
    } else {
      return Future.error(response.statusCode.toString());
    }
  }

  Future<dynamic> addStudent(String username, String token, int courseId) async {
    final http.Response response = await http.post(
      "$baseUrl/$username/students",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "Bearer " + token,
      },
      body: jsonEncode(<String, int>{
        'courseId': courseId,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Map<String, dynamic> body = json.decode(response.body);
      String error = body['error'];
      return Future.error(error);
    }
  }
}
