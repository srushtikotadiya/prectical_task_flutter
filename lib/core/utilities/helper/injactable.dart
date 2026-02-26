import 'package:get_it/get_it.dart';
import 'package:prectical_task_flutter/core/repositories/auth_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
}
