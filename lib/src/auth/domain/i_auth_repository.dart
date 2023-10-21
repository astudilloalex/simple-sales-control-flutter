import 'package:sales_control/src/common/domain/default_response.dart';

abstract class IAuthRepository {
  const IAuthRepository();

  Stream<DefaultResponse> authStateChanges();

  Future<DefaultResponse> get current;

  Future<DefaultResponse> signInWithGoogle({
    String? accessToken,
    String? idToken,
  });
}
