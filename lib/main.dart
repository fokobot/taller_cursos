import 'package:taller_cursos/models/user.dart';
import 'package:taller_cursos/screens/myhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() {
    setupLocator();
    runApp(ChangeNotifierProvider(
      create: (context) => UserModel(), child: MyHome()));
} 
