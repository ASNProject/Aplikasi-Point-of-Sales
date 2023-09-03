class ListProductModel {
  int? id;
  String? product;
  String? price;
  String? description;
  String? category;
  String? image;
  String? createAt;
  String? updateAt;

  ListProductModel(
      {this.id,
      this.product,
      this.price,
      this.description,
      this.category,
      this.image,
      this.createAt,
      this.updateAt});

  ListProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }
}
