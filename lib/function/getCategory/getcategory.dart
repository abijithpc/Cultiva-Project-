import 'package:cultiva/model/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CategoryProvider {
  List<String> getCategories() {
    final productBox = Hive.box<Product>('productBox');
    final allProducts = productBox.values.toList();
    final categoris = allProducts
        .map((product) => product.producttype ?? '')
        .toSet()
        .toList();
    return categoris;
  }
}
