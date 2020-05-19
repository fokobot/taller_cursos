import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/course_detail_model.dart';
import 'package:taller_cursos/widgets/persons_list.dart';

import '../models/user.dart';
import 'course_detail_view.dart';

class StudentsCourseView extends StatelessWidget {
  final int courseId;
  StudentsCourseView({this.courseId});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<UserModel>(context).username,
            Provider.of<UserModel>(context).token,
            courseId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Estudiantes del Curso"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                  child: Expanded(child: PersonsList(model.courseDetail.students)))),
                );
  }
}
