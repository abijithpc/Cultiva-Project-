import 'package:cultiva/function/soldquantity/soldquantity.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Outofstock extends StatelessWidget {
  const Outofstock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Out Of Stock"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder<Box<Product>>(
            valueListenable: Hive.box<Product>('productBox').listenable(),
            builder: (context, productBox, _) {
              final outOfStockProducts = productBox.values.where((product) {
                final initalStock =
                    num.tryParse(product.productQuantity.toString()) ?? 0;
                final soldQuantity = getSoldQuantity(product.productname);
                final remainingStock = initalStock - soldQuantity;
                return remainingStock <= 0;
              }).toList();
              if (outOfStockProducts.isEmpty) {
                return const Center(
                  child: Text(
                    "All Products are sufficiently stocked!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              }

              return ListView.builder(
                itemCount: outOfStockProducts.length,
                itemBuilder: (context, index) {
                  final product = outOfStockProducts[index];
                  final intialStock =
                      num.tryParse(product.productQuantity.toString()) ?? 0;
                  final soldQauntity = getSoldQuantity(product.productname);
                  final remainingStock = intialStock - soldQauntity;

                  return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productname!,
                                  style: GoogleFonts.judson(
                                      textStyle: TextStyle(fontSize: 20)),
                                ),
                                Text(
                                  "Remaining Stock: $remainingStock",
                                  style: GoogleFonts.judson(
                                      textStyle: TextStyle(
                                          color: Colors.red, fontSize: 18)),
                                ),
                                Text(
                                  product.price!,
                                  style: GoogleFonts.judson(
                                      textStyle: TextStyle(fontSize: 18)),
                                )
                              ],
                            )),
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 30,
                            )
                          ],
                        ),
                      ));
                },
              );
            },
          ),
        ));
  }
}
