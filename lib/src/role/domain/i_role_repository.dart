import 'package:sales_control/src/common/domain/default_response.dart';

abstract class IRoleRepository {
  const IRoleRepository();

  Future<DefaultResponse> findAll();
}
