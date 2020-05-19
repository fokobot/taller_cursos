import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taller_cursos/base/base_model.dart';
import 'package:taller_cursos/base/base_view.dart';
import 'package:taller_cursos/viewmodels/home_model.dart';

import '../models/user.dart';

class ListaCursos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
        onModelReady: (model) => getData(context, model),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Course list"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () {
                    Provider.of<UserModel>(context, listen: false)
                        .signOut();
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
                              Center(child: Text('${model.courses.length}')),
                              FlatButton(
                                  child: Text('get Detail'),
                                  onPressed: () => print("Hola mundo")
                                  //getDetail(context, model.courses[0].id)
                                  )
                            ],
                          ))));
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

  // void getDetail(BuildContext context, int courseId) async {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //         builder: (context) => CourseDetailView(courseId: courseId)),
  //   );
  // }

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
}
