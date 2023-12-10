import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get_it/get_it.dart';
import 'package:sales_control/app/services/i_sqlite.dart';
import 'package:sales_control/app/services/mobile_sqlite.dart';
import 'package:sales_control/src/auth/application/auth_service.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/auth/infrastructure/firebase_auth_repository.dart';
import 'package:sales_control/src/company/application/company_service.dart';
import 'package:sales_control/src/company/domain/i_company_repository.dart';
import 'package:sales_control/src/company/infrastructure/firebase_company_repository.dart';
import 'package:sales_control/src/customer/application/customer_service.dart';
import 'package:sales_control/src/customer/domain/i_customer_repository.dart';
import 'package:sales_control/src/customer/infrastructure/firebase_customer_repository.dart';
import 'package:sales_control/src/customer_search_history/application/customer_search_history_service.dart';
import 'package:sales_control/src/customer_search_history/domain/i_customer_search_history_repository.dart';
import 'package:sales_control/src/customer_search_history/infrastructure/sqlite_customer_search_history_repository.dart';
import 'package:sales_control/src/file/application/file_service.dart';
import 'package:sales_control/src/file/domain/i_file_repository.dart';
import 'package:sales_control/src/file/infrastructure/firebase_file_repository.dart';
import 'package:sales_control/src/product/application/product_service.dart';
import 'package:sales_control/src/product/domain/i_product_repository.dart';
import 'package:sales_control/src/product/infrastructure/firebase_product_repository.dart';
import 'package:sales_control/src/product_search_history/application/product_search_history_service.dart';
import 'package:sales_control/src/product_search_history/domain/i_product_search_history_repository.dart';
import 'package:sales_control/src/product_search_history/infrastructure/sqlite_product_search_history_repository.dart';
import 'package:sales_control/src/role/application/role_service.dart';
import 'package:sales_control/src/role/domain/i_role_repository.dart';
import 'package:sales_control/src/role/infrastructure/firebase_role_repository.dart';
import 'package:sales_control/src/sale/application/sale_service.dart';
import 'package:sales_control/src/sale/domain/i_sale_repository.dart';
import 'package:sales_control/src/sale/infrastructure/firebase_sale_repository.dart';
import 'package:sales_control/src/sale_summary/application/sale_summary_service.dart';
import 'package:sales_control/src/sale_summary/domain/i_sale_summary_repository.dart';
import 'package:sales_control/src/sale_summary/infrastructure/firebase_sale_summary_repository.dart';
import 'package:sqflite/sqflite.dart';

GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Local database
  if (!kIsWeb) {
    getIt.registerSingletonAsync<ISQLite>(
      () async => MobileSQLite.getInstance(await getDatabasesPath()),
    );
    await getIt.isReady<ISQLite>();
  }

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
  getIt.registerLazySingleton<ICustomerRepository>(
    () => FirebaseCustomerRepository(firestore),
  );
  getIt.registerLazySingleton<ICustomerSearchHistoryRepository>(
    () => SQLiteCustomerSearchHistoryRepository(getIt<ISQLite>()),
  );
  getIt.registerLazySingleton<IFileRepository>(
    () => FirebaseFileRepository(firebaseStorage),
  );
  getIt.registerLazySingleton<IProductRepository>(
    () => FirebaseProductRepository(firestore),
  );
  getIt.registerLazySingleton<IProductSearchHistoryRepository>(
    () => SQLiteProductSearchHistory(getIt<ISQLite>()),
  );
  getIt.registerLazySingleton<IRoleRepository>(
    () => FirebaseRoleRepository(firestore),
  );
  getIt.registerLazySingleton<ISaleRepository>(
    () => FirebaseSaleRepository(firestore),
  );
  getIt.registerLazySingleton<ISaleSummaryRepository>(
    () => FirebaseSaleSummaryRepository(firestore),
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
  getIt.registerFactory<CustomerSearchHistoryService>(
    () => CustomerSearchHistoryService(
      getIt<ICustomerSearchHistoryRepository>(),
    ),
  );
  getIt.registerFactory<CustomerService>(
    () => CustomerService(
      getIt<ICustomerRepository>(),
    ),
  );
  getIt.registerFactory<FileService>(
    () => FileService(getIt<IFileRepository>()),
  );
  getIt.registerFactory<ProductService>(
    () => ProductService(getIt<IProductRepository>()),
  );
  getIt.registerFactory<ProductSearchHistoryService>(
    () => ProductSearchHistoryService(getIt<IProductSearchHistoryRepository>()),
  );
  getIt.registerFactory<RoleService>(
    () => RoleService(getIt<IRoleRepository>()),
  );
  getIt.registerFactory<SaleService>(
    () => SaleService(getIt<ISaleRepository>()),
  );
  getIt.registerFactory<SaleSummaryService>(
    () => SaleSummaryService(getIt<ISaleSummaryRepository>()),
  );
}
