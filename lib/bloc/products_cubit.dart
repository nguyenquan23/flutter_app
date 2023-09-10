import 'package:first_app/bloc/products_state.dart';
import 'package:first_app/main.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../repository/product_repository.dart';
import '../services/product_service.dart';

@singleton
class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit(ProductRepository productRepository)
      : super(const ProductState(products: [], isLoading: true)) {
    _productRepository = productRepository;
    getProductsFromServer();
  }

  late ProductRepository _productRepository;

  Future getProductsFromServer() async {
    emit(state.copyWith(products: [], isLoading: true));
    List<Product> items = await _productRepository.getProducts();
    emit(state.copyWith(products: items, isLoading: false));
  }

  void selectProduct(Product product) {
    bool isExisted = state.selectedProducts?.contains(product) ?? false;
    if (isExisted) {
      emit(state.copyWith(
          selectedProducts:
              state.selectedProducts?.where((e) => e != product).toList()));
    } else {
      emit(state
          .copyWith(selectedProducts: [...?state.selectedProducts, product]));
    }
  }
}
