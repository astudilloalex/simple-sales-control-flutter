// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as String,
      name: json['name'] as String,
      owner: Auth.fromJson(json['owner'] as Map<String, dynamic>),
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => Auth.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner.toJson(),
      'users': instance.users.map((e) => e.toJson()).toList(),
    };
