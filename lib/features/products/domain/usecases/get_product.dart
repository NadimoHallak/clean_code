import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetProduct implements UseCase<Product, int> {
  final ProductsRepository repository;

  GetProduct(this.repository);

  @override
  Future<UseCaseResult<Product>> call(int id) async {
    return await repository.getProduct(id);
  }
}
