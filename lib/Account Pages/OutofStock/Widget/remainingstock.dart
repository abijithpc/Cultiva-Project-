import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemainingStock extends StatelessWidget {
  const RemainingStock({
    super.key,
    required this.product,
    required this.remainingStock,
  });

  final Product product;
  final num remainingStock;

  @override
  Widget build(BuildContext context) {
    return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
    Text(
      product.productname!,
      style: GoogleFonts.judson(
          textStyle: TextStyle(fontSize: 20)),
    ),
    Text(
      "Remaining Stock: $remainingStock",
      style: GoogleFonts.judson(
          textStyle: TextStyle(
              color: Colors.red, fontSize: 18)),
    ),
    Text(
      product.price!,
      style: GoogleFonts.judson(
          textStyle: TextStyle(fontSize: 18)),
    )
                                  ],
                                );
  }
}
