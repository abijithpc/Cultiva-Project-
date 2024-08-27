import 'package:cultiva/model/sellinfo.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> saveDetails({
  required String customerName,
  required String customerNumber,
  required String product,
  required int quantity,
  required Box<Sellinfo> sellBox,
}) async {
  final sellinfo = Sellinfo(
      customerName: customerName,
      customerNumber: customerNumber,
      product: product,
      quantity: quantity);
  await sellBox.add(sellinfo);
}
