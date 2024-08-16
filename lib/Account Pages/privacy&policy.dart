import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy & Policy",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Welcome to Cultiva\n At Cultiva, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application ('Cultiva'). By using our app, you agree to the collection and use of information in accordance with this policy.\n",
                style: GoogleFonts.judson(
                    textStyle: TextStyle(color: Colors.black, fontSize: 25)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
