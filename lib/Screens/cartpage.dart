import 'dart:io';

import 'package:cultiva/Screens/purchasedetailspage.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cartpage extends StatefulWidget {
  // final List<Sellinfo>? sellInfoList;
  // final List<Product>? productList;
  const Cartpage({
    super.key,
  });

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  late Box<Sellinfo> sellInfoBox;
  late Box<Product> productBox;

  @override
  void initState() {
    super.initState();
    sellInfoBox = Hive.box<Sellinfo>('sellBox');
    productBox = Hive.box<Product>('ProductBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell Details",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: sellInfoBox.listenable(),
        builder: (context, Box<Sellinfo> sellBox, _) {
          final sellInfoList = sellBox.values.toList();

          return ListView.builder(
            itemCount: sellInfoList.length,
            itemBuilder: (context, index) {
              final sellInfo = sellInfoList[index];
              final List<Map<String, dynamic>> purchasedProduct = [];
              final product = productBox.values.firstWhere(
                (prod) => prod.productname == sellInfo.product,
                orElse: () => Product(
                    productname: 'Unknown',
                    description: 'description',
                    price: '0',
                    productimage: '',
                    producttype: 'Unknown'),
              );

              purchasedProduct.add({'product': product, 'quantity': 1});

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Purchasedetailspage(
                              selectedProducts: purchasedProduct,
                              sellinfo: sellInfo)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 226, 226, 226),
                        borderRadius: BorderRadius.circular(10)),
                    width: 500,
                    height: 290,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  width: 130,
                                  height: 150,
                                  child: ClipRRect(
                                      child: Image.file(
                                    File(product.productimage.toString()),
                                    fit: BoxFit.cover,
                                  ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.productname ?? 'Product name',
                                          style: GoogleFonts.judson(
                                              textStyle: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Text(
                                          product.producttype,
                                          style: GoogleFonts.judson(
                                              textStyle: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Text(
                                          "₹${product.price}",
                                          style: GoogleFonts.judson(
                                              textStyle: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name:${sellInfo.customerName ?? 'customerName'}',
                                    style: GoogleFonts.judson(
                                        textStyle: TextStyle(fontSize: 18)),
                                  ),
                                  Text(
                                    'PhoneNumber: ${sellInfo.customerNumber ?? 'customerNumber'}',
                                    style: GoogleFonts.judson(
                                        textStyle: TextStyle(fontSize: 18)),
                                  ),
                                  Text(
                                    'Date: ${DateTime.now().toString().split(' ')[0]}',
                                    style: GoogleFonts.judson(
                                        textStyle: TextStyle(fontSize: 18)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
