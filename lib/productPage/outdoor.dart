import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Outdoor extends StatefulWidget {
  const Outdoor({super.key});

  @override
  State<Outdoor> createState() => _OutdoorState();
}

class _OutdoorState extends State<Outdoor> {
  @override
  Widget build(BuildContext context) {
    final Box<Product> ProductBox = Hive.box<Product>('productBox');
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Outdoor Plants",
            style: GoogleFonts.judson(
                textStyle:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: ProductBox.listenable(),
          builder: (context, Box<Product> box, _) {
            final outdoorPlants = box.values
                .where((product) => product.producttype == 'Outdoor')
                .toList();

            if (outdoorPlants.isEmpty) {
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
              itemCount: outdoorPlants.length,
              itemBuilder: (context, index) {
                final Product product = outdoorPlants[index];
                return Card(
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
                                    fontSize: 15, fontWeight: FontWeight.bold)),
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
                );
              },
            );
          },
        ));
  }
}
