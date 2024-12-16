import '../../domain/entities/product.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class GetProductEvent extends ProductsEvent {
  final int id;
  GetProductEvent(this.id);
}

class CreateProductEvent extends ProductsEvent {
  final Product product;
  CreateProductEvent(this.product);
}

class UpdateProductEvent extends ProductsEvent {
  final Product product;
  UpdateProductEvent(this.product);
}

class DeleteProductEvent extends ProductsEvent {
  final int id;
  DeleteProductEvent(this.id);
}
