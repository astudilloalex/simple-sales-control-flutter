import 'package:json_annotation/json_annotation.dart';
import 'package:sales_control/src/auth/domain/auth.dart';

part 'company.g.dart';

@JsonSerializable(explicitToJson: true)
class Company {
  const Company({
    required this.id,
    required this.name,
    required this.owner,
    this.users = const [],
  });

  final String id;
  final String name;
  final Auth owner;
  final List<Auth> users;

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
