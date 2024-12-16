import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductsRepository repository;

  GetProducts(this.repository);

  @override
  Future<UseCaseResult<List<Product>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
