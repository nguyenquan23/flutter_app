import 'package:dio/dio.dart';
import 'package:first_app/models/product.dart';
import 'package:injectable/injectable.dart';

@singleton
class ProductService {
  final dio = Dio();

  Future<List<Product>> getProducts() async {
    final response = await dio.get('https://fakestoreapi.com/products');
    var items = List.from(response.data);
    List<Product> products = [];
    for (var item in items) {
      products.add(Product.fromJson(item));
    }
    return products;
  }
}
