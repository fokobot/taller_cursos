import 'package:taller_cursos/screens/myhome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'services/auth_provider.dart';

void main() {
    setupLocator();
    runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(), child: MyHome()));
} 
