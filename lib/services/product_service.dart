import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:barcode_mobile/models/product.dart';

@injectable
class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<Product>> getMatchingItems(String nameToSearch) async {
    var response = await _dio.get("/products/search?limit=100&query=$nameToSearch");
    return (response.data as List).map((x) => Product.fromJson(x)).toList();
  }
}
