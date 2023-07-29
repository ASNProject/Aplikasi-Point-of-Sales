class ListProductModel {
  int? id;
  String? product;
  int? price;
  String? description;
  String? image;

  ListProductModel({
    this.id,
    this.product,
    this.price,
    this.description,
    this.image,
  });

  ListProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }
}
