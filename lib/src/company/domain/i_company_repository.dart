import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/company/domain/company.dart';

abstract class ICompanyRepository {
  const ICompanyRepository();

  /// Find all companies of the user.
  Future<DefaultResponse> findAll(String uid);
  Future<DefaultResponse> findById(String id);
  Future<DefaultResponse> save(Company company);
  Future<DefaultResponse> update(Company company);
}
