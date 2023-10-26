import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sales_control/src/common/domain/default_response.dart';
import 'package:sales_control/src/role/domain/i_role_repository.dart';

class FirebaseRoleRepository implements IRoleRepository {
  const FirebaseRoleRepository(this._client);

  final FirebaseFirestore _client;

  @override
  Future<DefaultResponse> findAll() async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await _client.collection('roles').get();
    final List<dynamic> jsonData = [];
    for (final QueryDocumentSnapshot<Map<String, dynamic>> element
        in data.docs) {
      jsonData.add(element.data());
    }
    return DefaultResponse(data: jsonData);
  }
}
