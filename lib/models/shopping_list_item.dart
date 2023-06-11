import 'package:json_annotation/json_annotation.dart';

part 'shopping_list_item.g.dart';

@JsonSerializable()
class ShoppingListItem {
  final int id;
  final int listId;
  final int? productId;

  final String name;
  final String? productBarcode;

  final String? thumbnailUrl;
  final String? barcodeImageUrl;

  final String updatedAt;
  final String createdAt;

  const ShoppingListItem(
      {required this.listId,
      required this.productId,
      required this.name,
      required this.productBarcode,
      required this.thumbnailUrl,
      required this.barcodeImageUrl,
      required this.id,
      required this.updatedAt,
      required this.createdAt});

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) => _$ShoppingListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ShoppingListItemToJson(this);
}
