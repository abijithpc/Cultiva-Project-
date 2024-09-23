import 'package:cultiva/model/sellinfo.dart';
import 'package:hive/hive.dart';

int getSoldQuantity(String? productName) {
  final sellInfos = Hive.box<Sellinfo>('sellBox').values.toList();
  return sellInfos
      .where((sellInfo) => sellInfo.product == productName)
      .fold(0, (sum, sellInfo) => sum + (sellInfo.quantity ?? 0));
}
