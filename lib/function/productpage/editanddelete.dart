import 'package:cultiva/model/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

void deleteProduct(Product product) {
  final box = Hive.box<Product>('productBox');
  box.delete(product.key);
}



