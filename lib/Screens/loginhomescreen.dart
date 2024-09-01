import 'package:cultiva/Screens/loginPage.dart';
import 'package:cultiva/Screens/signup.dart';
import 'package:cultiva/widget/carouselItems.dart';
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
                colors: [
                  Colors.green,
                  const Color.fromARGB(255, 199, 194, 194),
                ],
              ),
              const SizedBox(height: 30),
              CarouselItems(), 
              // const SizedBox(
              //   height: 20,
              // ),
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
                child: Column(
                  children: [
                    const SizedBox(height: 40), // Adjusted for balance
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Loginpage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(400, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Signup(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
                        minimumSize: const Size(400, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
