import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/i_company_repository.dart';
import 'package:sales_control/src/company/infrastructure/firebase_company_repository.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Declare services to pass to other services.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Declare repositories.
  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(firebaseAuth),
  );
  getIt.registerLazySingleton<ICompanyRepository>(
    () => FirebaseCompanyRepository(firestore),
  );

  // Declare services.
  getIt.registerFactory<AuthService>(
    () => AuthService(getIt<IAuthRepository>()),
  );
  getIt.registerFactory<CompanyService>(
    () => CompanyService(
      getIt<ICompanyRepository>(),
      authRepository: getIt<IAuthRepository>(),
    ),
  );
}
