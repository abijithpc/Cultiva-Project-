
import 'package:cultiva/Screens/loginhomescreens.dart/lLoginHomeScreenBtn/loginhomeScreenbtn.dart';
import 'package:cultiva/widget/carouselitems.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Loginhomescreen extends StatefulWidget {
  const Loginhomescreen({super.key});

  @override
  State<Loginhomescreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginhomescreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              GradientText(
                'Gardening is a work of a\n lifetime: you never finish',
                style: GoogleFonts.judson(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                colors: const [
                  Colors.green,
                  Color.fromARGB(255, 199, 194, 194),
                ],
              ),
              const SizedBox(height: 30),
              carousel_Items(),
              Container(
                padding: const EdgeInsets.all(45),
                width: screenWidth,
                height: screenheigth * 0.49,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 56, 120, 58),
                      Color.fromARGB(255, 12, 47, 13),
                    ],
                  ),
                ),
                child: LoginHomseScreenBtn(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
