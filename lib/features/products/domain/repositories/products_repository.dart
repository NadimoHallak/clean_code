import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';

abstract class ProductsRepository {
  Future<UseCaseResult<List<Product>>> getProducts();
  Future<UseCaseResult<Product>> getProduct(int id);
  Future<UseCaseResult<Product>> createProduct(Product product);
  Future<UseCaseResult<Product>> updateProduct(Product product);
  Future<UseCaseResult<void>> deleteProduct(int id);
}
