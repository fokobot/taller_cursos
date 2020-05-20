import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/data/course.dart';
import 'package:taller_cursos/viewmodels/home_model.dart';
import 'package:taller_cursos/widgets/students_view.dart';

import '../models/user.dart';
import 'course_detail_view.dart';
import 'professors_view.dart';

class ListaCursos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text("Lista de Cursos"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Provider.of<UserModel>(context, listen: false).signOut();
                    },
                  ),
                ],
              ),
              floatingActionButton: floating(context, model),
              body: model.state == ViewState.Busy
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: model.courses == null
                          ? Text('No data')
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Expanded(child: _list(context, model.courses)),
                              ],
                            )),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text('Drawer Header'),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      title: Text('Cursos'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Profesores'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ProfessorsView()),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Estudiantes'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => StudentsView()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ));
  }

  void getData(BuildContext context, HomeModel model) async {
    model
        .getCourses(Provider.of<UserModel>(context).username,
            Provider.of<UserModel>(context).token)
        .catchError((error) async {
      print("getCourses got error: " + error);
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<UserModel>(context, listen: false).signOut();
    });
  }

  void getDetail(BuildContext context, int courseId) async {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => CourseDetailView(courseId: courseId)),
    );
  }

  Widget floating(BuildContext context, HomeModel model) {
    return FloatingActionButton(
        onPressed: () => _onAdd(context, model),
        tooltip: 'Add task',
        child: new Icon(Icons.add));
  }

  void _onAdd(BuildContext context, HomeModel model) async {
    try {
      await model.addCourse();
    } catch (err) {
      print('upsss ${err.toString()}');
      await _buildDialog(context, 'Alert', 'Need to login');
      Provider.of<UserModel>(context, listen: false).signOut();
    }
  }

  Future<void> _buildDialog(BuildContext context, _title, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text(_title),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }

  Widget _list(BuildContext context, List<Course> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, posicion) {
        var element = items[posicion];
        return _item(context, element);
      },
    );
  }

  Widget _item(BuildContext context, Course element) {
    return Card(
      child: InkWell(
        onTap: () {
          getDetail(context, element.id);
        },
        child: Container(
          child: ListTile(
            title: Text(element.name),
            subtitle: Text(
                "Profesor: ${element.professor}\n# de estudiantes: ${element.students}"),
          ),
        ),
      ),
    );
  }
}
