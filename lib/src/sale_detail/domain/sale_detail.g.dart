// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleDetail _$SaleDetailFromJson(Map<String, dynamic> json) => SaleDetail(
      product: json['product'] == null
          ? const Product()
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      unitCost: (json['unitCost'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SaleDetailToJson(SaleDetail instance) =>
    <String, dynamic>{
      'product': instance.product.toJson(),
      'quantity': instance.quantity,
      'total': instance.total,
      'unitCost': instance.unitCost,
    };
