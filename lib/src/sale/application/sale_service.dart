import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/sale/domain/i_sale_repository.dart';
import 'package:sales_control/src/sale/domain/sale.dart';

class SaleService {
  const SaleService(this._repository);

  final ISaleRepository _repository;

  Future<Sale> save(Sale sale) async {
    final DefaultResponse response = await _repository.save(sale);
    return Sale.fromJson(response.data as Map<String, dynamic>);
  }
}
