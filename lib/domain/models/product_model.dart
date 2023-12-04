class ProductModel {
  String? id;
  String? name;
  String? category;
  double? price;
  String? image;
  String? description;
  int? quantity;
  double? totalAmount;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> data) {
    return ProductModel(
      id: data["id"],
      name: data["name"],
      category: data["category"],
      price: data["price"],
      image: data["image"],
      description: data["description"],
    );
  }
}
