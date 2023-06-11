import 'package:json_annotation/json_annotation.dart';

part 'shopping_list.g.dart';

@JsonSerializable()
class ShoppingList {
  final int id;
  final String listTitle;
  final String ownerUserId;
  final String updatedAt;
  final String createdAt;

  const ShoppingList(
      {required this.id,
      required this.listTitle,
      required this.ownerUserId,
      required this.updatedAt,
      required this.createdAt});


  factory ShoppingList.fromJson(Map<String, dynamic> json) => _$ShoppingListFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingListToJson(this);
}
