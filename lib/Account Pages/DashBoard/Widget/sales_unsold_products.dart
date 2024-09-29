import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SalesAndUnsoldProducts extends StatelessWidget {
  final int soldProducts;
  final num unsoldProducts;

  // ignore: use_super_parameters
  const SalesAndUnsoldProducts({
    Key? key,
    required this.soldProducts,
    required this.unsoldProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Number of Sales: $soldProducts",
            style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Text(
            "Unsold Product : $unsoldProducts",
            style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
