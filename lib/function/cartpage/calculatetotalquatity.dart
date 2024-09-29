import 'package:cultiva/model/sellinfo.dart';

int calculateTotalQuantity(Map<String, List<Sellinfo>> groupedSellinfo) {
  int totalQuantity = 0;
  for (var customerName in groupedSellinfo.keys) {
    final customerSellinfo = groupedSellinfo[customerName]!;
    for (var sellInfo in customerSellinfo) {
      totalQuantity += sellInfo.quantity ?? 0;
    }
  }
  return totalQuantity;
}
