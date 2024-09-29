import 'package:cultiva/Account%20Pages/OutofStock/Widget/outofstockcard.dart';
import 'package:cultiva/function/soldquantity/soldquantity.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
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

                  return OutOfStockCard(
                      product: product, remainingStock: remainingStock);
                },
              );
            },
          ),
        ));
  }
}
