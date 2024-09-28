import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCategoryHeader extends StatelessWidget {
  const ProductCategoryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(
        "Product Category",
        style: GoogleFonts.judson(
          textStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
