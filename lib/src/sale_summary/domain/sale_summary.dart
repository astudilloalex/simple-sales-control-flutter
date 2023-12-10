import 'package:json_annotation/json_annotation.dart';

part 'sale_summary.g.dart';

@JsonSerializable()
class SaleSummary {
  const SaleSummary({
    required this.dateTime,
    this.total = 0.0,
  });

  final DateTime dateTime;
  final double total;

  SaleSummary copyWith({
    DateTime? dateTime,
    double? total,
  }) {
    return SaleSummary(
      dateTime: dateTime ?? this.dateTime,
      total: total ?? this.total,
    );
  }

  factory SaleSummary.fromJson(Map<String, dynamic> json) =>
      _$SaleSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$SaleSummaryToJson(this);
}
