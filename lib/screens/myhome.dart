import 'package:taller_cursos/services/auth_provider.dart';
import 'package:taller_cursos/widgets/lista_cursos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
          body: Center(
              child: Consumer<AuthProvider>(builder: (context, user, child) {
            return user.status ? ListaCursos() : Login();
          })
        )
      )
    );
  }
}
