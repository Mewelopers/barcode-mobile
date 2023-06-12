import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductService {
  final Dio _dio;

  ProductService(this._dio);
}
