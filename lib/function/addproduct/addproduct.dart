import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Addproduct {
  Future<void> addProduct({
    required BuildContext context,
    required String productName,
    required String price,
    required String description,
    required String productType,
    required String productQuantity,
    File? productImage,
  }) async {
    var box = Hive.box<Product>('productBox');

    final product = Product(
        productname: productName,
        description: description,
        price: price,
        productimage: productImage?.path,
        producttype: productType,
        productQuantity: productQuantity);

    await box.add(product);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Product Added Successfully')));
  }
}
