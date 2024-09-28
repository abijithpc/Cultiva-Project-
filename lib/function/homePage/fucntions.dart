import 'package:hive_flutter/hive_flutter.dart';
import 'package:cultiva/model/product.dart';

// Function to load products from the Hive box
Future<List<Product>> loadProducts() async {
  final productBox = Hive.box<Product>('productBox');
  return productBox.values.toList();
}

// Function to filter products based on the search criteria
List<Product> filterProducts({
  required List<Product> allProducts,
  required String query,
  required String minPriceText,
  required String maxPriceText,
}) {
  final minPrice = double.tryParse(minPriceText) ?? 0.0;
  final maxPrice = double.tryParse(maxPriceText) ?? double.infinity;

  return allProducts.where((product) {
    final nameMatch = product.productname?.toLowerCase().contains(query.toLowerCase()) ?? false;
    final descriptionMatch = product.description?.toLowerCase().contains(query.toLowerCase()) ?? false;

    final double productPrice = double.tryParse(product.price ?? '') ?? 0.0;
    final priceMatch = productPrice >= minPrice && productPrice <= maxPrice;

    return (nameMatch || descriptionMatch) && priceMatch;
  }).toList();
}
