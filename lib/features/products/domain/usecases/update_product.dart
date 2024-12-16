import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class UpdateProduct implements UseCase<Product, Product> {
  final ProductsRepository repository;

  UpdateProduct(this.repository);

  @override
  Future<UseCaseResult<Product>> call(Product product) async {
    return await repository.updateProduct(product);
  }
}
