import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/sale/domain/i_sale_repository.dart';
import 'package:sales_control/src/sale/domain/sale.dart';

class FirebaseSaleRepository implements ISaleRepository {
  const FirebaseSaleRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> save(Sale sale) async {
    final QuerySnapshot<Map<String, dynamic>> saleSummary =
        await _collectionSummary(sale.companyId)
            .where(
              'dateTime',
              isEqualTo: sale.dateTime.copyWith(hour: 0, minute: 0, second: 0),
            )
            .get();
    final WriteBatch batch = _client.batch();
    if (saleSummary.docs.isEmpty) {
      batch.set(_collectionSummary(sale.companyId).doc(), {
        'dateTime': sale.dateTime.copyWith(hour: 0, minute: 0, second: 0),
        'total': sale.total,
      });
    } else {
      batch.update(saleSummary.docs.first.reference, {
        'total': sale.total,
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
