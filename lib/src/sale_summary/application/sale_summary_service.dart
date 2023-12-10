import 'package:sales_control/src/sale_summary/domain/i_sale_summary_repository.dart';
import 'package:sales_control/src/sale_summary/domain/sale_summary.dart';

class SaleSummaryService {
  const SaleSummaryService(this._repository);

  final ISaleSummaryRepository _repository;

  Stream<List<SaleSummary>> getLastSixMonths(
    String companyId,
    DateTime dateTime,
  ) {
    return _repository.getLastSixMonthsAgo(companyId, dateTime).map(
          (event) => (event.data as List<dynamic>)
              .map((json) => SaleSummary.fromJson(json as Map<String, dynamic>))
              .toList(),
        );
  }
}
