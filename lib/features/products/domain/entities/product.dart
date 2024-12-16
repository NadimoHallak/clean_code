class Product {
  final int? id; // null عند الإنشاء، سيتم تعيينه من API
  final String name;
  final String description;
  final double price;
  final int quantity;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          id == other.id &&
          name == other.name &&
          description == other.description &&
          price == price &&
          quantity == quantity;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      quantity.hashCode;
}
