import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RevenueSection extends StatelessWidget {
  const RevenueSection({
    super.key,
    required this.screenWidth,
    required this.screenheigth,
    required this.selectedDate,
    required this.revenueByDate,
  });

  final double screenWidth;
  final double screenheigth;
  final String? selectedDate;
  final Map<String, num> revenueByDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth * 0.5,
      height: screenheigth * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Revenue on: $selectedDate:",
                style: GoogleFonts.judson(
                    textStyle: TextStyle(
                        color: const Color.fromARGB(
                            255, 137, 235, 140),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Text(
              "₹${revenueByDate[selectedDate]!.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
