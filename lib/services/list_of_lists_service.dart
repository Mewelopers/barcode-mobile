import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/shopping_list.dart';

@injectable
class ListOfListsService {
  final Dio _dio;

  ListOfListsService(this._dio);

  Future<List<ShoppingList>> getLists() async {
    var response = await _dio.get("/lists");
    return (response.data as List).map((x) => ShoppingList.fromJson(x)).toList();
  }

  Future<void> deleteList(int id) async {
    await _dio.delete("/lists/$id");
  }

  Future<ShoppingList> createList(String listTitle) async {
    var response = await _dio.post("/lists", data: {"listTitle": listTitle});

    final newShoppingList = ShoppingList.fromJson(response.data);

    return newShoppingList;
  }

Future<ShoppingList> editList(String listTitle, int id) async {
    var response = await _dio.put("/lists/$id", data: {"listTitle": listTitle});

    final newShoppingList = ShoppingList.fromJson(response.data);

    return newShoppingList;
  }
}
