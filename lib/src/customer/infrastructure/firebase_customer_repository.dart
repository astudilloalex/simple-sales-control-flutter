import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/common/domain/util.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/customer/domain/i_customer_repository.dart';

class FirebaseCustomerRepository implements ICustomerRepository {
  const FirebaseCustomerRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> findAll(
    String companyId,
    int size, [
    Customer? lastElement,
  ]) async {
    QuerySnapshot<Map<String, dynamic>> firebaseData;
    if (lastElement != null) {
      firebaseData = await _collection(companyId)
          .orderBy('fullName')
          .startAfter([lastElement.lastName])
          .limit(size)
          .get();
    } else {
      firebaseData =
          await _collection(companyId).orderBy('fullName').limit(size).get();
    }
    return DefaultResponse(
      data: firebaseData.docs.map((e) => e.data()).toList(),
    );
  }

  @override
  Future<DefaultResponse> findById(String companyId, String id) async {
    final DocumentSnapshot<Map<String, dynamic>> data =
        await _collection(companyId).doc(id).get();
    return DefaultResponse(
      data: data.data(),
    );
  }

  @override
  Future<DefaultResponse> save(Customer customer) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _collection(customer.companyId).doc();
    final Customer saved = customer.copyWith(id: doc.id);
    final Map<String, dynamic> json = saved.toJson();
    json.addAll({
      'keywords': generateKeywords(customer.fullName.toUpperCase()),
    });
    await doc.set(json);
    return DefaultResponse(
      data: saved.toJson(),
    );
  }

  @override
  Future<DefaultResponse> update(Customer customer) async {
    await _collection(customer.companyId).doc(customer.id).update({
      'idCard': customer.idCard,
      'firstName': customer.firstName,
      'lastName': customer.lastName,
      'fullName': customer.fullName,
      'keywords': generateKeywords(customer.fullName.toUpperCase()),
    });
    return DefaultResponse(
      data: customer.toJson(),
    );
  }

  @override
  Future<DefaultResponse> delete(String companyId, String id) async {
    await _collection(companyId).doc(id).delete();
    return const DefaultResponse(
      data: true,
    );
  }

  @override
  Future<DefaultResponse> findByFullName(
    String companyId,
    String fullName,
  ) async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await _collection(companyId)
            .where('fullName', isEqualTo: fullName)
            .get();
    return DefaultResponse(data: data.docs.map((e) => e.data()).toList());
  }

  @override
  Future<DefaultResponse> findByIdCard(String companyId, String idCard) async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await _collection(companyId).where('idCard', isEqualTo: idCard).get();
    return DefaultResponse(data: data.docs.map((e) => e.data()).toList());
  }

  @override
  Future<DefaultResponse> findByKeyword(String companyId, String value) async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await _collection(companyId)
            .where('keywords', arrayContains: value)
            .get();
    return DefaultResponse(data: data.docs.map((e) => e.data()).toList());
  }

  CollectionReference<Map<String, dynamic>> _collection(String companyId) {
    return _client
        .collection('companies')
        .doc(companyId)
        .collection('customers');
  }
}
