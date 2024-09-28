import 'package:cultiva/model/sellinfo.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> saveDetails({
  required String customerName,
  required String customerNumber,
  required String product,
  required int quantity,
  required num totalPrice,
  required Box<Sellinfo> sellBox,
}) async {
  try {
    final sellinfo = Sellinfo(
        customerName: customerName,
        customerNumber: customerNumber,
        product: product,
        quantity: quantity,
        totalPrice: totalPrice,
        sellDate: DateTime.now());
    await sellBox.add(sellinfo);
  } catch (e) {
    print("$e");
  }
}
