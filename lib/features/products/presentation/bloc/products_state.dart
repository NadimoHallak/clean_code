import '../../domain/entities/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductLoaded extends ProductsState {
  final Product product;
  ProductLoaded(this.product);
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError(this.message);
}

class ProductCreated extends ProductsState {
  final Product product;
  ProductCreated(this.product);
}

class ProductUpdated extends ProductsState {
  final Product product;
  ProductUpdated(this.product);
}

class ProductDeleted extends ProductsState {}
