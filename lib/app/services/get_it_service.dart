import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/auth/infrastructure/firebase_auth_repository.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Declare services to pass to other services.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Declare repositories.
  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(firebaseAuth),
  );

  // Declare services.
  getIt.registerFactory(() => AuthService(getIt<IAuthRepository>()));
}
