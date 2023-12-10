// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSearchHistory _$ProductSearchHistoryFromJson(
  Map<String, dynamic> json,
) =>
    ProductSearchHistory(
      id: json['id'] as int? ?? 0,
      value: json['value'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$ProductSearchHistoryToJson(
  ProductSearchHistory instance,
) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'date': instance.date.toIso8601String(),
    };
