import 'package:json_annotation/json_annotation.dart';
import 'package:sales_control/src/role/domain/role.dart';

part 'auth.g.dart';

@JsonSerializable(explicitToJson: true)
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
    this.role,
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
  final Role? role;

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}
