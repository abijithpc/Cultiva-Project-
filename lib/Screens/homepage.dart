import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GradientText(
            'Greening up my spaces',
            style: GoogleFonts.judson(
                textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
            colors: [Colors.green, Color.fromARGB(255, 199, 194, 194)],
          ),
        ),
      ),
      body: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Search Plant',
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
