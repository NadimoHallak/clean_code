import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductsLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(int id);
  Future<void> cacheProducts(List<ProductModel> products);
  Future<void> cacheProduct(ProductModel product);
  Future<void> deleteProductFromCache(int id);
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final Box<ProductModel> productsBox;
  static const String PRODUCTS_BOX_NAME = 'products_box';

  ProductsLocalDataSourceImpl({required this.productsBox});

  static Future<ProductsLocalDataSourceImpl> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(ProductModelAdapter());
    }
    final box = await Hive.openBox<ProductModel>(PRODUCTS_BOX_NAME);
    return ProductsLocalDataSourceImpl(productsBox: box);
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final products = productsBox.values.toList();
      if (products.isEmpty) {
        throw CacheException();
      }
      return products;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final product = productsBox.values.firstWhere(
        (product) => product.id == id,
        orElse: () => throw CacheException(),
      );
      return product;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      await productsBox.clear();
      for (var product in products) {
        await productsBox.put(product.id, product);
      }
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    try {
      await productsBox.put(product.id, product);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteProductFromCache(int id) async {
    try {
      await productsBox.delete(id);
    } catch (e) {
      throw CacheException();
    }
  }
}
