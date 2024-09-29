import 'package:cultiva/Account%20Pages/OutofStock/Widget/remainingstock.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';

class OutOfStockCard extends StatelessWidget {
  const OutOfStockCard({
    super.key,
    required this.product,
    required this.remainingStock,
  });

  final Product product;
  final num remainingStock;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                  child: RemainingStock(
                      product: product,
                      remainingStock: remainingStock)),
              Icon(
                Icons.warning,
                color: Colors.red,
                size: 30,
              )
            ],
          ),
        ));
  }
}
