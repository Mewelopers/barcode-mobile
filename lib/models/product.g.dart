// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  name: json['name'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  barcode: json['barcode'] as String
);

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
  'name': instance.name,
  'thumbnailUrl': instance.thumbnailUrl,
  'barcode': instance.barcode
};
