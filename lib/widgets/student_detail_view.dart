import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/student_detail_model.dart';
import 'package:taller_cursos/widgets/person_detail_view.dart';

import '../models/user.dart';

class StudentDetailView extends StatelessWidget {
  final int studentId;

  StudentDetailView({this.studentId});

  @override
  Widget build(BuildContext context) {
    return BaseView<StudentDetailModel>(
        onModelReady: (model) => model.getStudent(
            Provider.of<UserModel>(context).username,
            Provider.of<UserModel>(context).token,
            studentId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Información del Estudiante"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: ProfilePage(model.student))));
  }
}
