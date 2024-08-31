import 'package:hive_flutter/hive_flutter.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String? productname;

  @HiveField(1)
  String? description;

  @HiveField(2)
  String? price;

  @HiveField(3)
  String? productimage;

  @HiveField(4)
  String producttype;

  Product(
      {required this.productname,
      required this.description,
      required this.price,
      required this.productimage,
      required this.producttype});
}
