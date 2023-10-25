// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) => Auth(
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tenantId: json['tenantId'] as String?,
      uid: json['uid'] as String,
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'isAnonymous': instance.isAnonymous,
      'phoneNumber': instance.phoneNumber,
      'photoURL': instance.photoURL,
      'refreshToken': instance.refreshToken,
      'tenantId': instance.tenantId,
      'uid': instance.uid,
      'role': instance.role?.toJson(),
    };
