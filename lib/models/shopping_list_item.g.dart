// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingListItem _$ShoppingListItemFromJson(Map<String, dynamic> json) =>
    ShoppingListItem(
      listId: json['listId'] as int,
      productId: json['productId'] as int?,
      name: json['name'] as String,
      productBarcode: json['productBarcode'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      barcodeImageUrl: json['barcodeImageUrl'] as String?,
      id: json['id'] as int,
      updatedAt: json['updatedAt'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ShoppingListItemToJson(ShoppingListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listId': instance.listId,
      'productId': instance.productId,
      'name': instance.name,
      'productBarcode': instance.productBarcode,
      'thumbnailUrl': instance.thumbnailUrl,
      'barcodeImageUrl': instance.barcodeImageUrl,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
