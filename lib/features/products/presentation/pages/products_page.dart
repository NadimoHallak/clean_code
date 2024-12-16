import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';
import '../bloc/products_event.dart';
import '../bloc/products_state.dart';
import '../widgets/product_form.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المنتجات'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsInitial) {
            context.read<ProductsBloc>().add(GetProductsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            return ProductsList(products: state.products);
          } else if (state is ProductsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ProductForm(
          onSubmit: (product) {
            context.read<ProductsBloc>().add(CreateProductEvent(product));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text(product.description),
          trailing: Text('\$${product.price}'),
          onTap: () => _showEditProductDialog(context, product),
          onLongPress: () => _showDeleteConfirmation(context, product),
        );
      },
    );
  }

  void _showEditProductDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ProductForm(
          product: product,
          onSubmit: (updatedProduct) {
            context.read<ProductsBloc>().add(UpdateProductEvent(updatedProduct));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المنتج'),
        content: Text('هل أنت متأكد من حذف ${product.name}؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<ProductsBloc>().add(DeleteProductEvent(product.id!));
              Navigator.pop(context);
            },
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
