// ignore_for_file: camel_case_types

import 'package:cultiva/Account%20Pages/revenuesection.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:fl_chart/fl_chart.dart';
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
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ValueListenableBuilder<Box<Product>>(
                valueListenable: Hive.box<Product>('productBox').listenable(),
                builder: (context, productBox, _) {
                  final totalProduct = productBox.length;

                  num totalQuantity =
                      productBox.values.fold<num>(0, (sum, product) {
                    try {
                      return sum +
                          (num.tryParse(product.productQuantity.toString()) ??
                              0);
                    } catch (e) {
                      return sum;
                    }
                  });

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Product:\n $totalProduct",
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: screenWidth * 0.26,
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            "Total Quantity:\n $totalQuantity",
                            style: GoogleFonts.judson(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ))),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 14,
              ),
              ValueListenableBuilder<Box<Product>>(
                valueListenable: Hive.box<Product>('ProductBox').listenable(),
                builder: (context, productBox, _) {
                  final totalProduct = productBox.length;

                  num totalQuantity =
                      productBox.values.fold<num>(0, (sum, product) {
                    try {
                      return sum +
                          (num.tryParse(product.productQuantity.toString()) ??
                              0);
                    } catch (e) {
                      return sum;
                    }
                  });
                  final unsoldProduct = totalQuantity - widget.soldProducts;

                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Number of Sales: ${widget.soldProducts}",
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ),
                            Text(
                              "Unsold Product : $unsoldProduct",
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Revenuesection()));
                        },
                        child: Container(
                            width: 160,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.blue[400],
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              "Total Revenue:\n ₹${widget.totalRevenue.toStringAsFixed(2)}",
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                            ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 250,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 5,
                                  blurRadius: 10)
                            ]),
                        child: PieChart(
                          PieChartData(
                              sections: getDoughNutData(
                                  widget.soldProducts, totalProduct),
                              centerSpaceRadius: 60,
                              sectionsSpace: 4),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Number of Sales')
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('Total Products')
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Product Stock",
                  style: GoogleFonts.judson(
                      textStyle: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold))),
              ValueListenableBuilder<Box<Product>>(
                valueListenable: Hive.box<Product>('productBox').listenable(),
                builder: (context, productBox, _) {
                  final products = productBox.values.toList();
                  final sellInfos =
                      Hive.box<Sellinfo>('sellBox').values.toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      final totalSold = sellInfos
                          .where((sellInfo) =>
                              sellInfo.product == product.productname)
                          .fold(
                              0,
                              (sum, sellInfo) =>
                                  sum + (sellInfo.quantity ?? 0));

                      final intialStock = num.tryParse(
                              product.productQuantity?.toString() ?? '0') ??
                          0;
                      return ListTile(
                        title: Text(product.productname ?? "Unamed Product"),
                        subtitle: Text(
                            "Stock: ${intialStock - totalSold} / $intialStock "),
                        trailing: Text("Price: ${product.price}"),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> getDoughNutData(
    int soldProducts,
    int totalProduct,
  ) {
    return [
      PieChartSectionData(
          color: Colors.green,
          value: soldProducts.toDouble(),
          title: '$soldProducts',
          radius: 50,
          titleStyle: GoogleFonts.judson(
              textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white))),
      PieChartSectionData(
          color: Colors.blue,
          value: totalProduct.toDouble(),
          title: '$totalProduct',
          radius: 50,
          titleStyle: GoogleFonts.judson(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))),
    ];
  }
}
