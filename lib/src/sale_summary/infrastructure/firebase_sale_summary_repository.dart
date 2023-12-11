import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/sale_summary/domain/i_sale_summary_repository.dart';

class FirebaseSaleSummaryRepository implements ISaleSummaryRepository {
  const FirebaseSaleSummaryRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Stream<DefaultResponse> getLastSixMonthsAgo(
    String companyId,
    DateTime dateTime,
  ) {
    final DateTime sixMonthsAgo = DateTime(
      dateTime.year,
      dateTime.month - 6,
      dateTime.day,
    );
    return _collection(companyId)
        .where('dateTime',
            isGreaterThanOrEqualTo: sixMonthsAgo.toIso8601String())
        .orderBy('dateTime')
        .snapshots()
        .map(
          (query) => DefaultResponse(
            data: query.docs.map((doc) => doc.data()).toList(),
          ),
        );
  }

  CollectionReference<Map<String, dynamic>> _collection(
    String companyId,
  ) {
    return _client
        .collection('companies')
        .doc(companyId)
        .collection('salessummary');
  }
}
