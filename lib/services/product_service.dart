import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:barcode_mobile/models/product.dart';

@injectable
class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<Product>> getMatchingProducts(String nameToSearch) async {
    var response = await _dio.get("/products/search?limit=100&query=$nameToSearch");
    return (response.data as List).map((x) => Product.fromJson(x)).toList();
  }

  Future<Product> getProduct(String barcode) async {
    var response = await _dio.get("/products/$barcode");
    return Product.fromJson(response.data);
  }
}
