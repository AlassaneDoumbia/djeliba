

import 'package:djeliba/services/auth.service.dart';
import 'package:djeliba/services/base.service.dart';
import 'package:djeliba/services/deliver.service.dart';
import 'package:djeliba/services/secure_storage.service.dart';
import 'package:djeliba/ui/view_models/details.view_model.dart';
import 'package:djeliba/ui/view_models/login.view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() async {
  locator.registerSingleton(BaseService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => DeliverService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => DetailsViewModel());
}