import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/professor_model.dart';
import 'package:taller_cursos/widgets/persons_list.dart';

import '../models/user.dart';
import 'professor_detail_view.dart';

class ProfessorsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfessorModel>(
      onModelReady: (model) => model.getProfessors(
          Provider.of<UserModel>(context).username,
          Provider.of<UserModel>(context).token),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text("Listado de Profesores"),
          ),
          body: model.state == ViewState.Busy
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Expanded(
                      child: PersonsList(
                  items: model.professors,
                  onTap: (element) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfessorDetailView(professorId: element.id)),
                    );
                  },
                )))),
    );
  }
}
