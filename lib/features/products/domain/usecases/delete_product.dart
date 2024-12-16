import '../../../../core/usecases/usecase.dart';
import '../repositories/products_repository.dart';

class DeleteProduct implements UseCase<void, int> {
  final ProductsRepository repository;

  DeleteProduct(this.repository);

  @override
  Future<UseCaseResult<void>> call(int id) async {
    return await repository.deleteProduct(id);
  }
}
