// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaleSummary _$SaleSummaryFromJson(Map<String, dynamic> json) => SaleSummary(
      dateTime: DateTime.parse(json['dateTime'] as String),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SaleSummaryToJson(SaleSummary instance) =>
    <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'total': instance.total,
    };
