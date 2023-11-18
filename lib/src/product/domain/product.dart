import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  const Product({
    this.id = '',
    this.name = '',
    this.description,
    this.photoUrls = const [],
    this.price = 0.0,
    this.quantity = 0.0,
  });

  final String id;
  final String name;
  final String? description;
  final List<String> photoUrls;
  final double price;
  final double quantity;

  Product copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? photoUrls,
    double? price,
    double? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
      photoUrls: photoUrls ?? this.photoUrls,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
