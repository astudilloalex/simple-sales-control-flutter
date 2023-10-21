class Auth {
  const Auth({
    this.displayName,
    this.email,
    this.emailVerified = false,
    this.isAnonymous = false,
    this.phoneNumber,
    this.photoURL,
    this.refreshToken,
    this.tenantId,
    required this.uid,
  });

  final String? displayName;
  final String? email;
  final bool emailVerified;
  final bool isAnonymous;
  final String? phoneNumber;
  final String? photoURL;
  final String? refreshToken;
  final String? tenantId;
  final String uid;
}
