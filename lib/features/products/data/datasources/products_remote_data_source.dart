import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(int id);
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;
  final String baseUrl = 'https://api.example.com/products'; // تغيير هذا حسب API الخاص بك

  ProductsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => ProductModel.fromJson(json))
            .toList();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await dio.get('$baseUrl/$id');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: product.toJson(),
      );
      if (response.statusCode == 201) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response = await dio.put(
        '$baseUrl/${product.id}',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    try {
      final response = await dio.delete('$baseUrl/$id');
      if (response.statusCode != 204) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
