import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String barcode;
  final String name;
  final String thumbnailUrl;

  const Product({
    required this.name,
    required this.barcode,
    required this.thumbnailUrl
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
