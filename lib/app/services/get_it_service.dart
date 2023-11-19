import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/i_company_repository.dart';
import 'package:sales_control/src/company/infrastructure/firebase_company_repository.dart';
import 'package:sales_control/src/file/application/file_service.dart';
import 'package:sales_control/src/file/domain/i_file_repository.dart';
import 'package:sales_control/src/file/infrastructure/firebase_file_repository.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/i_product_repository.dart';
import 'package:sales_control/src/product/infrastructure/firebase_product_repository.dart';
import 'package:sales_control/src/role/application/role_service.dart';
import 'package:sales_control/src/role/domain/i_role_repository.dart';
import 'package:sales_control/src/role/infrastructure/firebase_role_repository.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Declare services to pass to other services.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  // Declare repositories.
  getIt.registerLazySingleton<IAuthRepository>(
    () => FirebaseAuthRepository(firebaseAuth),
  );
  getIt.registerLazySingleton<ICompanyRepository>(
    () => FirebaseCompanyRepository(firestore),
  );
  getIt.registerLazySingleton<IFileRepository>(
    () => FirebaseFileRepository(firebaseStorage),
  );
  getIt.registerLazySingleton<IProductRepository>(
    () => FirebaseProductRepository(firestore),
  );
  getIt.registerLazySingleton<IRoleRepository>(
    () => FirebaseRoleRepository(firestore),
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
  getIt.registerFactory<FileService>(
    () => FileService(getIt<IFileRepository>()),
  );
  getIt.registerFactory<ProductService>(
    () => ProductService(getIt<IProductRepository>()),
  );
  getIt.registerFactory<RoleService>(
    () => RoleService(getIt<IRoleRepository>()),
  );
}
