import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage(
                    'Assets/Backgroundimage/filip-zrnzevic-_EMkxLdko9k-unsplash.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Text(
              "A beautifull plant is like\n having a friend around the house",
              style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 17)),
            ),
            SizedBox(
              height: 80,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 100,
                height: 100,
                child: Text("Get Started"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
