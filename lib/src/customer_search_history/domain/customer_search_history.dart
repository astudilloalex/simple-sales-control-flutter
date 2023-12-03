import 'package:json_annotation/json_annotation.dart';

part 'customer_search_history.g.dart';

@JsonSerializable()
class CustomerSearchHistory {
  const CustomerSearchHistory({
    this.id = 0,
    required this.value,
    required this.date,
  });

  final int id;
  final String value;
  final DateTime date;

  CustomerSearchHistory copyWith({
    int? id,
    String? value,
    DateTime? date,
  }) {
    return CustomerSearchHistory(
      id: id ?? this.id,
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  factory CustomerSearchHistory.fromJson(Map<String, dynamic> json) =>
      _$CustomerSearchHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerSearchHistoryToJson(this);
}
