import 'package:json_annotation/json_annotation.dart';

part 'role.g.dart';

@JsonSerializable(explicitToJson: true)
class Role {
  const Role({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
