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
  });

  final String id;
  final String companyId;
  final String idCard;
  final String firstName;
  final String lastName;

  Customer copyWith({
    String? companyId,
    String? id,
    String? idCard,
    String? firstName,
    String? lastName,
  }) {
    return Customer(
      companyId: companyId ?? this.companyId,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      idCard: idCard ?? this.idCard,
      lastName: lastName ?? this.lastName,
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
