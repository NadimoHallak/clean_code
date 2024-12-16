import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/network/network_info.dart';
import 'features/users/data/datasources/users_local_data_source.dart';
import 'features/users/data/datasources/users_remote_data_source.dart';
import 'features/users/data/repositories/users_repository_impl.dart';
import 'features/users/domain/repositories/users_repository.dart';
import 'features/users/domain/usecases/get_users.dart';
import 'features/users/presentation/bloc/users_bloc.dart';
import 'features/products/data/datasources/products_local_data_source.dart';
import 'features/products/data/datasources/products_remote_data_source.dart';
import 'features/products/data/repositories/products_repository_impl.dart';
import 'features/products/domain/repositories/products_repository.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/get_product.dart';
import 'features/products/domain/usecases/create_product.dart';
import 'features/products/domain/usecases/update_product.dart';
import 'features/products/domain/usecases/delete_product.dart';
import 'features/products/presentation/bloc/products_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Users
  // Bloc
  sl.registerFactory(
    () => UsersBloc(getUsers: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UsersRemoteDataSource>(
    () => UsersRemoteDataSourceImpl(dio: sl()),
  );
  
  sl.registerLazySingleton<UsersLocalDataSource>(
    () => UsersLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Features - Products
  // Bloc
  sl.registerFactory(
    () => ProductsBloc(
      getProducts: sl(),
      getProduct: sl(),
      createProduct: sl(),
      updateProduct: sl(),
      deleteProduct: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProduct(sl()));
  sl.registerLazySingleton(() => CreateProduct(sl()));
  sl.registerLazySingleton(() => UpdateProduct(sl()));
  sl.registerLazySingleton(() => DeleteProduct(sl()));

  // Repository
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductsRemoteDataSourceImpl(dio: sl()),
  );
  
  // تسجيل ProductsLocalDataSource
  final productsLocalDataSource = await ProductsLocalDataSourceImpl.init();
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => productsLocalDataSource,
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  await Hive.initFlutter();
  final sharedPreferences = await Hive.openBox('sharedPreferences');
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
