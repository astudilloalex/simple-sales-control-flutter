import 'package:json_annotation/json_annotation.dart';

part 'product_search_history.g.dart';

@JsonSerializable()
class ProductSearchHistory {
  const ProductSearchHistory({
    this.id = 0,
    required this.value,
    required this.date,
  });

  final int id;
  final String value;
  final DateTime date;

  ProductSearchHistory copyWith({
    int? id,
    String? value,
    DateTime? date,
  }) {
    return ProductSearchHistory(
      id: id ?? this.id,
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  factory ProductSearchHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchHistoryToJson(this);
}
