import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell Details",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
    );
  }
}
