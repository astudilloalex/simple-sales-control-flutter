import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/src/company/domain/i_company_repository.dart';

class CompanyService {
  const CompanyService(this._repository, {required this.authRepository});

  final ICompanyRepository _repository;
  final IAuthRepository authRepository;

  Future<List<Company>> getAll() async {
    final DefaultResponse authResponse = await authRepository.current;
    final User? user = authResponse.data as User?;
    final DefaultResponse response = await _repository.findAll(user?.uid ?? '');
    return (response.data as List<dynamic>)
        .map((json) => Company.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Company?> getById(String id) async {
    final DefaultResponse response = await _repository.findById(id);
    if (response.data == null) return null;
    return Company.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Company?> getMyCompany() async {
    final DefaultResponse authResponse = await authRepository.current;
    final User? user = authResponse.data as User?;
    final DefaultResponse response = await _repository.findById(
      user?.uid ?? '',
    );
    if (response.data == null) return null;
    return Company.fromJson(response.data as Map<String, dynamic>);
  }

  Future<Company> save(Company company) async {
    await _repository.save(company);
    return company;
  }

  Future<Company> update(Company company, {bool updateUsers = false}) async {
    await _repository.update(company, updateUsers: updateUsers);
    return company;
  }
}
