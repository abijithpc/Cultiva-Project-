import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Productdetails extends StatelessWidget {
  final Product product;

  const Productdetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.productname!,
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
                child: product.productimage != null
                    ? Image.file(
                        File(product.productimage!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                      )
                    : Text("Image Not Added")),
            SizedBox(
              height: 10,
            ),
            Text(
              "Description",
              style: GoogleFonts.judson(
                  textStyle: TextStyle(
                      fontSize: 25,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                product.description ?? "No description available",
                style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 280,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 22, 95, 24),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                  child: Text(
                "Price: ₹${product.price!}",
                style: GoogleFonts.judson(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              )),
            )
          ],
        ),
      ),
    );
  }
}
