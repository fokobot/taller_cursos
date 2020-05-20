import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/student_model.dart';
import 'package:taller_cursos/widgets/persons_list.dart';
import 'package:taller_cursos/widgets/student_detail_view.dart';

import '../models/user.dart';

class StudentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<StudentModel>(
      onModelReady: (model) => model.getStudents(
          Provider.of<UserModel>(context).username,
          Provider.of<UserModel>(context).token),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Listado de Estudiantes"),
          ),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Expanded(
                      child: PersonsList(
                  items: model.students,
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
}
