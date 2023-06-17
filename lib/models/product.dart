import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String barcode;
  final String name;
  final String? description;
  final String? manufacturer;
  final String? thumbnailUuid;
  final String? thumbnailUrl;
  final String? barcodeImageUuid;
  final String? barcodeImageUrl;

  const Product(
      {required this.thumbnailUuid,
      required this.barcodeImageUuid,
      required this.description,
      required this.manufacturer,
      required this.barcodeImageUrl,
      required this.barcode,
      required this.name,
      required this.thumbnailUrl});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
