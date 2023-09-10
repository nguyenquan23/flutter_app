import 'package:first_app/main.dart';
import 'package:first_app/services/product_service.dart';
import 'package:injectable/injectable.dart';

import '../models/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

@Injectable(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  late ProductService _productService;
  ProductRepositoryImpl(ProductService productService) {
    _productService = productService;
  }

  @override
  Future<List<Product>> getProducts() {
    return _productService.getProducts();
  }
}
