// ignore_for_file: library_private_types_in_public_api

import 'package:cultiva/Screens/MainPage/mainpage.dart';
import 'package:cultiva/Screens/loginhomescreens.dart/loginhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after a delay
    Future.delayed(Duration(seconds: 6), () {
      // Replace this with your logic to check if the user is logged in
      bool isLoggedIn = checkUserLoggedIn();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => isLoggedIn
              ? Mainpage(selectedProduct: null, sellinfo: null)
              : Loginhomescreen(),
        ),
      );
    });
  }

  bool checkUserLoggedIn() {
    // Logic to check if user is logged in (e.g., checking Hive box)
    final authBox = Hive.box('authBox');
    return authBox.get('isLoggedIn', defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage(
                  'Assets/Backgroundimage/filip-zrnzevic-_EMkxLdko9k-unsplash.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for better text visibility
          Container(
            color: Colors.black.withOpacity(0.6), // Semi-transparent overlay
          ),
          // Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "A beautiful plant is like\nhaving a friend around the house",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.judson(
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
