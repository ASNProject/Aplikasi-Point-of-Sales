import 'package:hive_flutter/hive_flutter.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? price;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? category;
  @HiveField(4)
  String? imageUrl;

  ProductModel({
    this.name,
    this.price,
    this.description,
    this.category,
    this.imageUrl,
  });
}
