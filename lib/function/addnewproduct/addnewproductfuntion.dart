import 'dart:io';

import 'package:cultiva/function/addproduct/addproduct.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

List<String> getCategories(List<Product> allProducts) {
  final categories = allProducts
      .map((product) => product.producttype ?? '')
      .where((type) => type.isNotEmpty)
      .toSet()
      .toList();
  return categories;
}

Future<File?> pickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<void> addProduct({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required TextEditingController productController,
  required TextEditingController priceController,
  required TextEditingController descriptionController,
  required String selectCategory,
  required File? selectedProductImage,
}) async {
  if (formKey.currentState!.validate()) {
    final productName = productController.text;
    final price = priceController.text;
    final description = descriptionController.text;
    final productType = selectCategory;

    await Addproduct().addProduct(
      context: context,
      productName: productName,
      price: price,
      description: description,
      productType: productType,
      productImage: selectedProductImage,
    );

    productController.clear();
    priceController.clear();
    descriptionController.clear();
    Navigator.pop(context);
  }
}
