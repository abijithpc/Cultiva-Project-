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
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 47),
          child: Column(
            children: [
              GradientText(
                  'Gardening is a work of a\n lifetime: you never finish',
                  style: GoogleFonts.judson(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  colors: [
                    Colors.green,
                    const Color.fromARGB(255, 199, 194, 194)
                  ]),
              SizedBox(
                height: 0,
              ),
              Column(
                children: [CarouselItems()],
              ),
              SizedBox(
                height: 99,
              ),
              Container(
                padding: EdgeInsets.all(20),
                width: ScreenWidth * 1,
                height: Screenheigth * 1,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(
                          255,
                          142,
                          200,
                          144,
                        ),
                        Color.fromARGB(255, 12, 47, 13),
                      ],
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Loginpage()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                         Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Signup()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 23, 65, 24),
                          minimumSize: Size(300, 60),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        "SignUp",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
