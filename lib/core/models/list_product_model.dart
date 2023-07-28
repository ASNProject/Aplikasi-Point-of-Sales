class ListProductModel {
  int? id;
  String? product;
  String? price;
  String? description;

  ListProductModel({
    this.id,
    this.product,
    this.price,
    this.description,
  });

  ListProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
  }
}
