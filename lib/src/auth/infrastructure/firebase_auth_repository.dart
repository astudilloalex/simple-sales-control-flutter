import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/common/domain/default_response.dart';

class FirebaseAuthRepository implements IAuthRepository {
  const FirebaseAuthRepository(this._client);

  final FirebaseAuth _client;

  @override
  Stream<DefaultResponse> authStateChanges() {
    return _client.authStateChanges().map((user) {
      return DefaultResponse(data: user);
    });
  }

  @override
  // TODO: implement current
  Future<DefaultResponse> get current async {
    await Future.delayed(const Duration(milliseconds: 1));
    return DefaultResponse(data: _client.currentUser);
  }

  @override
  Future<DefaultResponse> signInWithGoogle({
    String? accessToken,
    String? idToken,
  }) async {
    final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );
    final UserCredential credential = await _client.signInWithCredential(
      oAuthCredential,
    );
    return DefaultResponse(data: credential.user);
  }
}
