import 'package:hive_flutter/hive_flutter.dart';

part 'sale_model.g.dart';

@HiveType(typeId: 2)
class SaleModel {
  @HiveField(0)
  String? date;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? name;
  @HiveField(3)
  int? quantity;
  @HiveField(4)
  double? price;
  @HiveField(5)
  String? note;

  SaleModel({
    this.date,
    this.time,
    this.name,
    this.quantity,
    this.price,
    this.note,
  });
}
