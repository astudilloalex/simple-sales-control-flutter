// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sale _$SaleFromJson(Map<String, dynamic> json) => Sale(
      id: json['id'] as String? ?? '',
      companyId: json['companyId'] as String? ?? '',
      customer: json['customer'] == null
          ? const Customer(fullName: '')
          : Customer.fromJson(json['customer'] as Map<String, dynamic>),
      dateTime: DateTime.parse(json['dateTime'] as String),
      saleDetails: (json['saleDetails'] as List<dynamic>?)
              ?.map((e) => SaleDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SaleToJson(Sale instance) => <String, dynamic>{
      'companyId': instance.companyId,
      'customer': instance.customer.toJson(),
      'dateTime': instance.dateTime.toIso8601String(),
      'id': instance.id,
      'saleDetails': instance.saleDetails.map((e) => e.toJson()).toList(),
      'total': instance.total,
    };
