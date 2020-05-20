import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/professor_detail_model.dart';
import 'package:taller_cursos/widgets/person_detail_view.dart';

import '../models/user.dart';

class ProfessorDetailView extends StatelessWidget {
  final int professorId;
  ProfessorDetailView({this.professorId});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfessorDetailModel>(
        onModelReady: (model) => model.getProfessor(
            Provider.of<UserModel>(context).username,
            Provider.of<UserModel>(context).token,
            professorId),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Información del Profesor"),
            ),
            body: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: ProfilePage(
                        name: model.professor.email,
                        username: model.professor.username,
                        email: model.professor.email,
                        phone: model.professor.phone,
                        city: model.professor.city,
                        country: model.professor.country,
                        birthdate: model.professor.birthdate))));
  }
}
