import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/course_detail_model.dart';
import 'package:taller_cursos/widgets/students_course_view.dart';

import '../models/user.dart';
import 'professor_detail_view.dart';

class CourseDetailView extends StatelessWidget {
  final int courseId;
  CourseDetailView({this.courseId});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<UserModel>(context).username,
            Provider.of<UserModel>(context).token,
            courseId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Detalle del Curso"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(child: Text('${model.courseDetail.name}')),
                      // Ver listado de estudiantes
                      FlatButton(
                        child: Text("Estudiantes"),
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    StudentsCourseView(courseId: courseId)),
                          )
                        },
                      ),
                      // Ver listado de estudiantes
                      FlatButton(
                        child: Text("Detalle Profesor"),
                        onPressed: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProfessorDetailView(
                                    professorId:
                                        model.courseDetail.professor.id)),
                          )
                        },
                      )
                    ],
                  ))));
  }
}
