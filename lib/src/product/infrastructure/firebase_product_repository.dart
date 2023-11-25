import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/product/domain/i_product_repository.dart';
import 'package:sales_control/src/product/domain/product.dart';

class FirebaseProductRepository implements IProductRepository {
  const FirebaseProductRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> findAll(
    String companyId,
    int size, [
    Product? lastElement,
  ]) async {
    QuerySnapshot<Map<String, dynamic>> firebaseData;
    if (lastElement != null) {
      firebaseData = await _collection(companyId)
          .orderBy('name')
          .startAfter([lastElement.name])
          .limit(size)
          .get();
    } else {
      firebaseData =
          await _collection(companyId).orderBy('name').limit(size).get();
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
  Future<DefaultResponse> save(String companyId, Product product) async {
    final DocumentReference<Map<String, dynamic>> doc =
        _collection(companyId).doc();
    final Product savedProduct = product.copyWith(id: doc.id);
    await doc.set(savedProduct.toJson());
    return DefaultResponse(
      data: savedProduct.toJson(),
    );
  }

  @override
  Future<DefaultResponse> update(String companyId, Product product) async {
    await _collection(companyId).doc(product.id).update({
      'name': product.name,
      'description': product.description,
      'photoUrls': product.photoUrls,
      'price': product.price,
    });
    return DefaultResponse(
      data: product.toJson(),
    );
  }

  @override
  Future<DefaultResponse> addInventory(
    String companyId,
    String id,
    double quantity,
  ) async {
    double newQuantity = 0.0;
    await _client.runTransaction((transaction) async {
      final DocumentSnapshot doc = await transaction.get(
        _collection(companyId).doc(id),
      );
      final Decimal total =
          Decimal.parse((doc.get('quantity') as double).toStringAsFixed(5)) +
              Decimal.parse(quantity.toStringAsFixed(5));
      newQuantity = total.toDouble();
      transaction.update(
        _collection(companyId).doc(id),
        {'quantity': newQuantity},
      );
    });
    return DefaultResponse(data: newQuantity);
  }

  CollectionReference<Map<String, dynamic>> _collection(String companyId) {
    return _client
        .collection('companies')
        .doc(companyId)
        .collection('products');
  }
}
