import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_control/src/auth/domain/auth.dart';
import 'package:sales_control/src/auth/domain/i_auth_repository.dart';
import 'package:sales_control/src/common/domain/default_response.dart';

class AuthService {
  const AuthService(this._repository);

  final IAuthRepository _repository;

  Future<Auth?> get current async {
    final DefaultResponse response = await _repository.current;
    final User? user = response.data as User?;
    if (user == null) return null;
    return Auth(
      displayName: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      refreshToken: user.refreshToken,
      tenantId: user.tenantId,
      uid: user.uid,
    );
  }

  Stream<Auth?> authStateChanges() {
    return _repository.authStateChanges().map((response) {
      final User? user = response.data as User?;
      if (user == null) return null;
      return Auth(
        displayName: user.displayName,
        email: user.email,
        emailVerified: user.emailVerified,
        isAnonymous: user.isAnonymous,
        phoneNumber: user.phoneNumber,
        photoURL: user.photoURL,
        refreshToken: user.refreshToken,
        tenantId: user.tenantId,
        uid: user.uid,
      );
    });
  }

  Future<Auth> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final DefaultResponse response = await _repository.signInWithGoogle(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final User user = response.data as User;
    return Auth(
      displayName: user.displayName,
      email: user.email,
      emailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
      phoneNumber: user.phoneNumber,
      photoURL: user.photoURL,
      refreshToken: user.refreshToken,
      tenantId: user.tenantId,
      uid: user.uid,
    );
  }
}
