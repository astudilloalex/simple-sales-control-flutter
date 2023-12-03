// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_search_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerSearchHistory _$CustomerSearchHistoryFromJson(
        Map<String, dynamic> json) =>
    CustomerSearchHistory(
      id: json['id'] as int? ?? 0,
      value: json['value'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$CustomerSearchHistoryToJson(
        CustomerSearchHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'date': instance.date.toIso8601String(),
    };
