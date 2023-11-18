import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/company/domain/company.dart';
import 'package:sales_control/src/company/domain/i_company_repository.dart';

class FirebaseCompanyRepository implements ICompanyRepository {
  const FirebaseCompanyRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> findAll(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> companies = await _client
        .collection('companies')
        .where('users.id', arrayContains: uid)
        .get();
    final List<dynamic> data = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> company
        in companies.docs) {
      data.add(company.data());
    }
    return DefaultResponse(data: data);
  }

  @override
  Future<DefaultResponse> findById(String id) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _client.collection('companies').doc(id).get();
    return DefaultResponse(
      data: doc.data(),
    );
  }

  @override
  Future<DefaultResponse> save(Company company) async {
    await _client.collection('companies').doc(company.id).set(company.toJson());
    return DefaultResponse(
      data: company.toJson(),
    );
  }

  @override
  Future<DefaultResponse> update(
    Company company, {
    bool updateUsers = false,
  }) async {
    final Map<String, dynamic> data = company.toJson();
    if (!updateUsers) {
      data.removeWhere((key, value) => key == 'owner' || key == 'users');
    }
    await _client.collection('companies').doc(company.id).update(data);
    return DefaultResponse(data: company);
  }
}
