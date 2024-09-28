import 'package:cultiva/model/product.dart';

/// This function adds the selected product to the selectedProducts list.
void addProductToSelection(
    {Product? selectedProductObject,
    required List<Map<String, dynamic>> selectedProducts}) {
  if (selectedProductObject != null) {
    selectedProducts.add({
      'product': selectedProductObject,
      'quantity': 1, // Default quantity
    });
  }
}
