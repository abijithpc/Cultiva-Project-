import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GradientText(
        'Greening up my spaces',
        style: GoogleFonts.judson(
          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        colors: [Colors.green, Color.fromARGB(255, 199, 194, 194)],
      ),
    );
  }
}
