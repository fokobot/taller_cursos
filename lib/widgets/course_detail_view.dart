import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/services/auth_provider.dart';
import 'package:taller_cursos/viewmodels/course_detail_model.dart';

import 'course_detail.dart';

class CourseDetailView extends StatelessWidget {
  final int courseId;
  CourseDetailView({this.courseId});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseDetailModel>(
        onModelReady: (model) => model.getCourse(
            Provider.of<AuthProvider>(context).username,
            Provider.of<AuthProvider>(context).token,
            courseId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Detalle del Curso"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : CourseDetail(
                    coursename: model.courseDetail.name,
                    courseId: courseId,
                    professorId: model.courseDetail.professor.id)));
  }
}
