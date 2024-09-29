import 'package:cultiva/Account%20Pages/DashBoard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalTotalPrice extends StatelessWidget {
  const FinalTotalPrice({
    super.key,
    required this.finalTotalPrice,
    required this.totalQuantity,
  });

  final double finalTotalPrice;
  final int totalQuantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20)),
        child: GestureDetector(
          child: Center(
            child: Text(
              "Final Total Price: ₹${finalTotalPrice.toStringAsFixed(2)}",
              style: GoogleFonts.judson(
                  textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color:
                          const Color.fromARGB(255, 14, 14, 14))),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => dashboard(
                          totalRevenue: finalTotalPrice,
                          soldProducts: totalQuantity,
                        )));
          },
        ),
      ),
    );
  }
}