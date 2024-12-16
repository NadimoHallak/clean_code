import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_data_source.dart';
import '../datasources/products_remote_data_source.dart';
import '../models/product_model.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<UseCaseResult<List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return UseCaseResult.success(remoteProducts);
      } on ServerException {
        try {
          final localProducts = await localDataSource.getProducts();
          return UseCaseResult.success(localProducts);
        } on CacheException {
          return UseCaseResult.failure(ServerFailure());
        }
      }
    } else {
      try {
        final localProducts = await localDataSource.getProducts();
        return UseCaseResult.success(localProducts);
      } on CacheException {
        return UseCaseResult.failure(NetworkFailure());
      }
    }
  }

  @override
  Future<UseCaseResult<Product>> getProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(id);
        await localDataSource.cacheProduct(remoteProduct);
        return UseCaseResult.success(remoteProduct);
      } on ServerException {
        try {
          final localProduct = await localDataSource.getProduct(id);
          return UseCaseResult.success(localProduct);
        } on CacheException {
          return UseCaseResult.failure(ServerFailure());
        }
      }
    } else {
      try {
        final localProduct = await localDataSource.getProduct(id);
        return UseCaseResult.success(localProduct);
      } on CacheException {
        return UseCaseResult.failure(NetworkFailure());
      }
    }
  }

  @override
  Future<UseCaseResult<Product>> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        final createdProduct = await remoteDataSource.createProduct(productModel);
        await localDataSource.cacheProduct(createdProduct);
        return UseCaseResult.success(createdProduct);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }

  @override
  Future<UseCaseResult<Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel.fromEntity(product);
        final updatedProduct = await remoteDataSource.updateProduct(productModel);
        await localDataSource.cacheProduct(updatedProduct);
        return UseCaseResult.success(updatedProduct);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }

  @override
  Future<UseCaseResult<void>> deleteProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteProduct(id);
        await localDataSource.deleteProductFromCache(id);
        return  UseCaseResult.success(null);
      } on ServerException {
        return UseCaseResult.failure(ServerFailure());
      }
    } else {
      return UseCaseResult.failure(NetworkFailure());
    }
  }
}
