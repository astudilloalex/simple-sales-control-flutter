import 'package:json_annotation/json_annotation.dart';
import 'package:sales_control/src/customer/domain/customer.dart';
import 'package:sales_control/src/sale_detail/domain/sale_detail.dart';

part 'sale.g.dart';

@JsonSerializable(explicitToJson: true)
class Sale {
  const Sale({
    this.id = '',
    this.companyId = '',
    this.customer = const Customer(fullName: ''),
    required this.dateTime,
    this.saleDetails = const [],
    this.total = 0.0,
  });

  final String companyId;
  final Customer customer;
  final DateTime dateTime;
  final String id;
  final List<SaleDetail> saleDetails;
  final double total;

  Sale copyWith({
    String? companyId,
    Customer? customer,
    DateTime? dateTime,
    String? id,
    List<SaleDetail>? saleDetails,
    double? total,
  }) {
    return Sale(
      companyId: companyId ?? this.companyId,
      customer: customer ?? this.customer,
      dateTime: dateTime ?? this.dateTime,
      id: id ?? this.id,
      saleDetails: saleDetails ?? this.saleDetails,
      total: total ?? this.total,
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json) => _$SaleFromJson(json);

  Map<String, dynamic> toJson() => _$SaleToJson(this);
}
