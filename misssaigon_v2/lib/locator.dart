import 'package:get_it/get_it.dart';
import 'package:misssaigon/API/login.dart';
import 'package:misssaigon/blocs/visistor_blocs.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => API());
  locator.registerLazySingleton(() => AppState());
}
