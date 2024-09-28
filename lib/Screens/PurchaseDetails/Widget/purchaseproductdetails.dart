import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseProductDetails extends StatelessWidget {
  const PurchaseProductDetails({
    super.key,
    required this.product,
    required this.sellInfo,
  });

  final Product product;
  final Sellinfo sellInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.productname ?? 'Product Name',
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Text(
          "Product Type: ${product.producttype}",
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Text(
          "Quantity: ${sellInfo.quantity}",
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        Text(
          "Price: ₹${product.price}",
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}