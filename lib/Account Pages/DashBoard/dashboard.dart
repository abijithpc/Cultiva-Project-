// ignore_for_file: camel_case_types

import 'package:cultiva/Account%20Pages/DashBoard/Widget/legend_row.dart';
import 'package:cultiva/Account%20Pages/DashBoard/Widget/product_info_row.dart';
import 'package:cultiva/Account%20Pages/DashBoard/Widget/product_pie_chart.dart';
import 'package:cultiva/Account%20Pages/DashBoard/Widget/product_stock_list.dart';
import 'package:cultiva/Account%20Pages/DashBoard/Widget/sales_unsold_products.dart';
import 'package:cultiva/Account%20Pages/DashBoard/Widget/total_revenue_card.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class dashboard extends StatefulWidget {
  final int soldProducts;
  final double totalRevenue;
  const dashboard({
    super.key,
    this.totalRevenue = 0.0,
    this.soldProducts = 0,
  });

  @override
  State<dashboard> createState() => _OverviewState();
}

class _OverviewState extends State<dashboard> {
  TextEditingController addQuantityCntlr = TextEditingController();
  TextEditingController editController = TextEditingController();
  String selectedTImeRange = 'Week';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.judson(textStyle: TextStyle(fontSize: 26)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ValueListenableBuilder<Box<Product>>(
              valueListenable: Hive.box<Product>('productBox').listenable(),
              builder: (context, productBox, _) {
                final totalProduct = productBox.length;
                num totalQuantity =
                    productBox.values.fold<num>(0, (sum, product) {
                  return sum +
                      (num.tryParse(product.productQuantity.toString()) ?? 0);
                });

                return ProductInfoRow(
                  totalProduct: totalProduct,
                  totalQuantity: totalQuantity,
                  screenWidth: screenWidth,
                );
              },
            ),
            SizedBox(height: 14),
            ValueListenableBuilder<Box<Product>>(
              valueListenable: Hive.box<Product>('productBox').listenable(),
              builder: (context, productBox, _) {
                final totalProduct = productBox.length;
                num totalQuantity =
                    productBox.values.fold<num>(0, (sum, product) {
                  return sum +
                      (num.tryParse(product.productQuantity.toString()) ?? 0);
                });
                final unsoldProduct = totalQuantity - widget.soldProducts;

                return Column(
                  children: [
                    SalesAndUnsoldProducts(
                      soldProducts: widget.soldProducts,
                      unsoldProducts: unsoldProduct,
                    ),
                    SizedBox(height: 10),
                    TotalRevenueCard(
                      totalRevenue: widget.totalRevenue,
                      onTap: () {
                        // Handle navigation to revenue section
                      },
                    ),
                    SizedBox(height: 20),
                    ProductPieChart(
                        soldProducts: widget.soldProducts,
                        totalProduct: totalProduct),
                  ],
                );
              },
            ),
            SizedBox(height: 16),
            LegendRow(),
            SizedBox(height: 20),
            Text(
              "Product Stock",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            ProductStockList(),
          ],
        ),
      ),
    );
  }
}
