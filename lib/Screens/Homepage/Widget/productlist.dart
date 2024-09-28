import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/productdetails.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final List<Product> filteredProducts;

  const ProductList({Key? key, required this.filteredProducts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: product.productimage != null
              ? Image.file(
                  File(product.productimage!),
                  width: 60,
                  height: 120,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.image, color: Colors.grey, size: 60),
          title: Text(product.productname ?? 'No Name'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Productdetails(product: product),
              ),
            );
          },
        );
      },
    );
  }
}
