import 'package:cultiva/Screens/Signup/Widget/signup_appbar.dart';
import 'package:cultiva/Screens/Signup/Widget/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: SignupAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('Assets/Backgroundimage/raihan-n-aziz-vXqYyGs3_Pc-unsplash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.judson(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 5,
                        color: Color.fromARGB(255, 104, 98, 98),
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              SignupForm(),
            ],
          ),
        ),
      ),
    );
  }
}
