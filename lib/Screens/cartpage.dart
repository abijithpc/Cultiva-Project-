import 'package:cultiva/model/cartdata.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cartpage extends StatefulWidget {
  final List<Sellinfo>? sellInfoList;
  final List<Product>? productList;
  const Cartpage({super.key, this.sellInfoList, this.productList});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  late Box cartBox;

  void initState() {
    super.initState();
    cartBox = Hive.box('cartBox');
    saveCartData();
  }

  void saveCartData() {
    final productList = widget.productList ?? [];
    final sellInfoList = widget.sellInfoList ?? [];

    for (int i = 0; i < productList.length; i++) {
      final product = productList[i];
      final sellInfo = i < sellInfoList.length ? sellInfoList[i] : null;

      final cartItem = Cartdata(product: product, sellinfo: sellInfo);
      cartBox.put(product.productname!, cartItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productList = widget.productList ?? [];
    final sellInfoList = widget.sellInfoList ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell Details",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          final sellInfo =
              sellInfoList.length > index ? sellInfoList[index] : null;
          return Padding(
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
                                child: Image.asset(
                              product.productimage ??
                                  'Assets/PlantsImage/nick-hillier-AhAxCcVajHk-unsplash.jpg',
                              fit: BoxFit.cover,
                            ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    product.price ?? 'productPrice',
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
                              'Name:${sellInfo?.customerName ?? 'customerName'}',
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(fontSize: 18)),
                            ),
                            Text(
                              'PhoneNumber: ${sellInfo?.customerNumber ?? 'customerNumber'}',
                              style: GoogleFonts.judson(
                                  textStyle: TextStyle(fontSize: 18)),
                            ),
                            Text(
                              'Quantity: ${sellInfo?.quantity ?? 'quantity'}',
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
          );
        },
      ),
    );
  }
}
