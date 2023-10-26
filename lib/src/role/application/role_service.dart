import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/role/domain/i_role_repository.dart';
import 'package:sales_control/src/role/domain/role.dart';

class RoleService {
  const RoleService(this._repository);

  final IRoleRepository _repository;

  Future<List<Role>> get all async {
    final DefaultResponse response = await _repository.findAll();
    return (response.data as List<dynamic>)
        .map((json) => Role.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
