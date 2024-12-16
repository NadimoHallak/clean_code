import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final Function(Product) onSubmit;

  const ProductForm({
    Key? key,
    this.product,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name);
    _descriptionController = TextEditingController(text: widget.product?.description);
    _priceController = TextEditingController(
      text: widget.product?.price.toString(),
    );
    _quantityController = TextEditingController(
      text: widget.product?.quantity.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.product == null ? 'إضافة منتج جديد' : 'تعديل المنتج',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'اسم المنتج',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال اسم المنتج';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'وصف المنتج',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال وصف المنتج';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'السعر',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال السعر';
                      }
                      if (double.tryParse(value) == null) {
                        return 'الرجاء إدخال رقم صحيح';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'الكمية',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال الكمية';
                      }
                      if (int.tryParse(value) == null) {
                        return 'الرجاء إدخال رقم صحيح';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text(widget.product == null ? 'إضافة' : 'تحديث'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: widget.product?.id,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
      );
      widget.onSubmit(product);
    }
  }
}
