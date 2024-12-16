import 'package:hive/hive.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends Product {
  @HiveField(0)
  final int? id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String description;
  
  @HiveField(3)
  final double price;
  
  @HiveField(4)
  final int quantity;

  const ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          quantity: quantity,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      quantity: product.quantity,
    );
  }
}
