import 'package:get_it/get_it.dart';
import 'package:taller_cursos/services/api.dart';
import 'package:taller_cursos/viewmodels/home_model.dart';

import 'services/courses_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => CourseService());
  locator.registerLazySingleton(() => Api());
  //locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => HomeModel());
  //locator.registerFactory(() => CourseDetailModel());
}