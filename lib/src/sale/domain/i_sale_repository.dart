import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/sale/domain/sale.dart';

abstract class ISaleRepository {
  const ISaleRepository();

  Future<DefaultResponse> save(Sale sale);
}
