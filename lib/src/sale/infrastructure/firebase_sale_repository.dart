import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/sale/domain/i_sale_repository.dart';
import 'package:sales_control/src/sale/domain/sale.dart';
import 'package:sales_control/src/sale_summary/domain/sale_summary.dart';

class FirebaseSaleRepository implements ISaleRepository {
  const FirebaseSaleRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> save(Sale sale) async {
    final QuerySnapshot<Map<String, dynamic>> salesSummary =
        await _collectionSummary(sale.companyId)
            .where(
              'dateTime',
              isEqualTo: sale.dateTime
                  .copyWith(
                    hour: 0,
                    minute: 0,
                    second: 0,
                    day: 1,
                    microsecond: 0,
                    millisecond: 0,
                  )
                  .toIso8601String(),
            )
            .get();
    final WriteBatch batch = _client.batch();
    if (salesSummary.docs.isEmpty) {
      batch.set(
        _collectionSummary(sale.companyId).doc(),
        SaleSummary(
          dateTime: sale.dateTime.copyWith(
            hour: 0,
            minute: 0,
            second: 0,
            day: 1,
            microsecond: 0,
            millisecond: 0,
          ),
          total: sale.total,
        ).toJson(),
      );
    } else {
      batch.update(salesSummary.docs.first.reference, {
        'total':
            (Decimal.parse(salesSummary.docs.first.get('total').toString()) +
                    Decimal.parse(sale.total.toString()))
                .toDouble(),
      });
    }
    final DocumentReference<Map<String, dynamic>> doc =
        _collection(sale.companyId).doc();
    batch.set(doc, sale.copyWith(id: doc.id).toJson());
    await batch.commit();
    return DefaultResponse(data: sale.copyWith(id: doc.id).toJson());
  }

  CollectionReference<Map<String, dynamic>> _collection(String companyId) {
    return _client.collection('companies').doc(companyId).collection('sales');
  }

  CollectionReference<Map<String, dynamic>> _collectionSummary(
    String companyId,
  ) {
    return _client
        .collection('companies')
        .doc(companyId)
        .collection('salessummary');
  }
}
