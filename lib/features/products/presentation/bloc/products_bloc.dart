import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/update_product.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  final GetProduct getProduct;
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductsBloc({
    required this.getProducts,
    required this.getProduct,
    required this.createProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductsInitial()) {
    on<GetProductsEvent>(_onGetProducts);
    on<GetProductEvent>(_onGetProduct);
    on<CreateProductEvent>(_onCreateProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onGetProducts(
    GetProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await getProducts(NoParams());
    if (result.isSuccess) {
      emit(ProductsLoaded(result.data!));
    } else {
      emit(ProductsError(result.error!.toString()));
    }
  }

  Future<void> _onGetProduct(
    GetProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await getProduct(event.id);
    if (result.isSuccess) {
      emit(ProductLoaded(result.data!));
    } else {
      emit(ProductsError(result.error!.toString()));
    }
  }

  Future<void> _onCreateProduct(
    CreateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await createProduct(event.product);
    if (result.isSuccess) {
      emit(ProductCreated(result.data!));
      add(GetProductsEvent()); // تحديث القائمة
    } else {
      emit(ProductsError(result.error!.toString()));
    }
  }

  Future<void> _onUpdateProduct(
    UpdateProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await updateProduct(event.product);
    if (result.isSuccess) {
      emit(ProductUpdated(result.data!));
      add(GetProductsEvent()); // تحديث القائمة
    } else {
      emit(ProductsError(result.error!.toString()));
    }
  }

  Future<void> _onDeleteProduct(
    DeleteProductEvent event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());
    final result = await deleteProduct(event.id);
    if (result.isSuccess) {
      emit(ProductDeleted());
      add(GetProductsEvent()); // تحديث القائمة
    } else {
      emit(ProductsError(result.error!.toString()));
    }
  }
}
