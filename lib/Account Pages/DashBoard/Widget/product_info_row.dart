import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductInfoRow extends StatelessWidget {
  final int totalProduct;
  final num totalQuantity;
  final double screenWidth;

  // ignore: use_super_parameters
  const ProductInfoRow({
    Key? key,
    required this.totalProduct,
    required this.totalQuantity,
    required this.screenWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: screenWidth * 0.6,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Total Product:\n $totalProduct",
              style: GoogleFonts.judson(
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          width: screenWidth * 0.26,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Total Quantity:\n $totalQuantity",
              style: GoogleFonts.judson(
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
