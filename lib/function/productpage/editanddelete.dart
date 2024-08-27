import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

void deleteProduct(Product product) {
  final box = Hive.box<Product>('productBox');
  box.delete(product.key);
}



