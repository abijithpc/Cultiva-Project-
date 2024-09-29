import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalRevenueCard extends StatelessWidget {
  final double totalRevenue;
  final Function onTap;

  // ignore: use_super_parameters
  const TotalRevenueCard({
    Key? key,
    required this.totalRevenue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 160,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.blue[400],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            "Total Revenue:\n ₹${totalRevenue.toStringAsFixed(2)}",
            style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
