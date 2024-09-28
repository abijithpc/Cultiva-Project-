import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';

class PurchaseProductImage extends StatelessWidget {
  const PurchaseProductImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: product.productimage != null && product.productimage!.isNotEmpty
          ? Image.file(
              File(product.productimage!),
              width: 130,
              height: 150,
              fit: BoxFit.cover,
            )
          : Container(
              width: 130,
              height: 150,
              color: Colors.grey[300],
              child: const Icon(
                Icons.image,
                size: 50,
              ),
            ),
    );
  }
}