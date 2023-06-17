// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      thumbnailUuid: json['thumbnailUuid'] as String?,
      barcodeImageUuid: json['barcodeImageUuid'] as String?,
      description: json['description'] as String?,
      manufacturer: json['manufacturer'] as String?,
      barcodeImageUrl: json['barcodeImageUrl'] as String?,
      barcode: json['barcode'] as String,
      name: json['name'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'barcode': instance.barcode,
      'name': instance.name,
      'description': instance.description,
      'manufacturer': instance.manufacturer,
      'thumbnailUuid': instance.thumbnailUuid,
      'thumbnailUrl': instance.thumbnailUrl,
      'barcodeImageUuid': instance.barcodeImageUuid,
      'barcodeImageUrl': instance.barcodeImageUrl,
    };
