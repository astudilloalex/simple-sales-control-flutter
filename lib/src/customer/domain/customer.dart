import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer {
  const Customer({
    this.companyId = '',
    this.id = '',
    this.idCard = '',
    this.firstName = '',
    this.lastName = '',
    required this.fullName,
  });

  final String id;
  final String companyId;
  final String idCard;
  final String firstName;
  final String lastName;
  final String fullName;

  Customer copyWith({
    String? companyId,
    String? id,
    String? idCard,
    String? firstName,
    String? lastName,
    String? fullName,
  }) {
    return Customer(
      companyId: companyId ?? this.companyId,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      idCard: idCard ?? this.idCard,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
