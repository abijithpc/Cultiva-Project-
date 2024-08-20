import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Indoor extends StatefulWidget {
  const Indoor({super.key});

  @override
  State<Indoor> createState() => _IndoorState();
}

class _IndoorState extends State<Indoor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Indoor Plants",
            style: GoogleFonts.judson(
                textStyle:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Product>('productBox').listenable(),
          builder: (context, Box<Product> box, _) {
            final IndoorPlants = box.values
                .where(
                    (product) => product.producttype.toLowerCase() == 'indoor')
                .toList();

            if (IndoorPlants.isEmpty) {
              return Center(
                child: Text("No Product added Yet"),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.75),
              itemCount: IndoorPlants.length,
              itemBuilder: (context, index) {
                final product = IndoorPlants[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Productdetails(product: product,),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: product.productimage != null
                              ? Image.file(
                                  File(product.productimage!),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Image.asset(
                                  'Assets/PlantsImage/nick-hillier-AhAxCcVajHk-unsplash.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              product.productname!,
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color.fromARGB(255, 50, 126, 53),
                              ),
                              child: Center(
                                  child: Text(
                                "₹${product.price!}",
                                style: GoogleFonts.judson(
                                    textStyle: TextStyle(color: Colors.white)),
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
