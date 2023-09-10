import '../models/product.dart';

class ProductState {
  const ProductState(
      {this.products, this.isLoading = true, this.selectedProducts});
  final List<Product>? products;
  final bool isLoading;
  final List<Product>? selectedProducts;

  ProductState copyWith(
          {List<Product>? products,
          bool? isLoading,
          List<Product>? selectedProducts}) =>
      ProductState(
          products: products ?? this.products,
          isLoading: isLoading ?? this.isLoading,
          selectedProducts: selectedProducts ?? this.selectedProducts);
}
