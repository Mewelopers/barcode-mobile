import 'package:barcode_mobile/models/shopping_list_item.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductListService {
  final Dio _dio;

  ProductListService(this._dio);

  Future<List<ShoppingListItem>> getProductListItems(int listId) async {
    var response = await _dio.get("/lists/$listId/items");
    return (response.data as List).map((x) => ShoppingListItem.fromJson(x)).toList();
  }

  Future<ShoppingListItem> createProductListItem(int listId, String name, String? barcode) async {
    Response<dynamic> response;
    if (barcode == null) {
      response = await _dio.post("/lists/$listId/items", data: {"name": name});
    }
    else {
      response = await _dio.post("/lists/$listId/items", data: {"name": name, "barcode": barcode});
    }

    final newShoppingList = ShoppingListItem.fromJson(response.data);

    return newShoppingList;
  }

  Future<ShoppingListItem> editList(int id, String name, String? barcode) async {
    Response<dynamic> response;
    if (barcode == null) {
      response = await _dio.put("/list-items/$id", data: {"name": name});
    }
    else {
      response = await _dio.put("/list-items/$id", data: {"name": name, "barcode": barcode});
    }

    final newShoppingList = ShoppingListItem.fromJson(response.data);

    return newShoppingList;
  }

  Future<void> deleteProductListItem(int id) async {
    await _dio.delete("/list-items/$id");
  }
}
