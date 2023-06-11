// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingList _$ShoppingListFromJson(Map<String, dynamic> json) => ShoppingList(
      id: json['id'] as int,
      listTitle: json['listTitle'] as String,
      ownerUserId: json['ownerUserId'] as String,
      updatedAt: json['updatedAt'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$ShoppingListToJson(ShoppingList instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listTitle': instance.listTitle,
      'ownerUserId': instance.ownerUserId,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
