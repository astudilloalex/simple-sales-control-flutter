import 'package:sales_control/src/common/domain/default_response.dart';

abstract class ISaleSummaryRepository {
  const ISaleSummaryRepository();

  Stream<DefaultResponse> getLastSixMonthsAgo(
    String companyId,
    DateTime dateTime,
  );
}
