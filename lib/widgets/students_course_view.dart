import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/course_detail_model.dart';
import 'package:taller_cursos/widgets/persons_list.dart';
import 'package:taller_cursos/widgets/student_detail_view.dart';

import '../models/user.dart';

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
          floatingActionButton: floating(context, model),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Expanded(
                      child: PersonsList(
                  items: model.courseDetail.students,
                  onTap: (element) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              StudentDetailView(studentId: element.id)),
                    );
                  },
                )))),
    );
  }

  Widget floating(BuildContext context, CourseDetailModel model) {
    return FloatingActionButton(
        onPressed: () => _onAdd(context, model),
        tooltip: 'Añadir Estudiante',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, CourseDetailModel model) async {
    try {
      await model.addStudent(Provider.of<UserModel>(context).username,
          Provider.of<UserModel>(context).token, this.courseId);
    } catch (err) {
      Provider.of<UserModel>(context, listen: false).signOut();
    }
  }
}
