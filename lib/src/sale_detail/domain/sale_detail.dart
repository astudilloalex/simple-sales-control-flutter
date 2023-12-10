import 'package:json_annotation/json_annotation.dart';
import 'package:sales_control/src/product/domain/product.dart';

part 'sale_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class SaleDetail {
  const SaleDetail({
    this.product = const Product(),
    this.quantity = 0.0,
    this.total = 0.0,
    this.unitCost = 0.0,
  });

  final Product product;
  final double quantity;
  final double total;
  final double unitCost;

  SaleDetail copyWith({
    Product? product,
    double? quantity,
    double? total,
    double? unitCost,
  }) {
    return SaleDetail(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      unitCost: unitCost ?? this.unitCost,
    );
  }

  factory SaleDetail.fromJson(Map<String, dynamic> json) =>
      _$SaleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SaleDetailToJson(this);
}
