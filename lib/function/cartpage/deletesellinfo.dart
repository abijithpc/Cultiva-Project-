import 'package:hive_flutter/hive_flutter.dart';
import 'package:cultiva/model/sellinfo.dart';

void deleteSellInfo(Box<Sellinfo> sellInfoBox, String customerName) {
  final entriesToDelete = sellInfoBox.values
      .where((sellInfo) => sellInfo.customerName == customerName)
      .toList();
  for (var sellInfo in entriesToDelete) {
    sellInfoBox.delete(sellInfo.key);
  }
}
