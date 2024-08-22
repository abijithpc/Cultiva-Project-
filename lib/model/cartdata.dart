import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:hive_flutter/hive_flutter.dart';


@HiveType(typeId: 3)
class Cartdata extends HiveObject {
  @HiveField(0)
  late Product product;

  @HiveField(1)
  late Sellinfo? sellinfo;

  Cartdata({required this.product, required this.sellinfo});
}
