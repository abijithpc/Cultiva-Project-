import 'dart:io';

import 'package:cultiva/function/soldquantity/soldquantity.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Productdetails extends StatelessWidget {
  final Product product;

  const Productdetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;

    final initalStock = int.tryParse(product.productQuantity.toString()) ?? 0;
    final soldQuantity = getSoldQuantity(product.productname);
    final remainingStock = initalStock - soldQuantity;
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
              height: 40,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: screenWidth * 0.5,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 22, 95, 24),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Product Quantity: $remainingStock",
                        style: GoogleFonts.judson(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 22, 95, 24),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "Price: ₹${product.price}",
                        style: GoogleFonts.judson(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                      )),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
