import 'package:hive_flutter/hive_flutter.dart';

part 'sellinfo.g.dart';


@HiveType(typeId: 2)
class Sellinfo extends HiveObject {
  @HiveField(0)
  String? customerName;

  @HiveField(1)
  String? customerNumber;

  @HiveField(2)
  String? product;

  @HiveField(3)
  int? quantity;

  Sellinfo(
      {required this.customerName,
      required this.customerNumber,
      required this.product,
      required this.quantity});
}
