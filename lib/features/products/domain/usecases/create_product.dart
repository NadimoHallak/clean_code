import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class CreateProduct implements UseCase<Product, Product> {
  final ProductsRepository repository;

  CreateProduct(this.repository);

  @override
  Future<UseCaseResult<Product>> call(Product product) async {
    return await repository.createProduct(product);
  }
}
