import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Purchasedetailspage extends StatelessWidget {
  final String customerName;
  final List<Sellinfo> customerSellInfo;
  const Purchasedetailspage(
      {Key? key, required this.customerName, required this.customerSellInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductBox = Hive.box<Product>('productBox');

    final Sellinfo customerDetails = customerSellInfo.first;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Details",
          style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'Assets/Backgroundimage/pexels-ian-panelo-3571551.jpg',
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Details",
                        style: GoogleFonts.judson(
                            textStyle: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Name ${customerDetails.customerName ?? 'Unknown'}'),
                      Text(
                          'Number ${customerDetails.customerNumber ?? 'Unknown'}'),
                      Text('Date ${DateTime.now().toString().split(' ')[0]}')
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("Purchased Product"))),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerSellInfo.length,
                itemBuilder: (context, index) {
                  final sellInfo = customerSellInfo[index];
                  final product = ProductBox.values.firstWhere(
                      (prod) => prod.productname == sellInfo.product,
                      orElse: () => Product(
                            productname: 'productname',
                            description: 'description',
                            price: 'price',
                            productimage: '',
                            producttype: 'producttype',
                          ));

                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF0E3311).withOpacity(0.3)),
                      child: Card(
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(
                            product.productname ?? 'Product Name',
                            style: GoogleFonts.judson(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                "Product Type: ${product.producttype}",
                                style: GoogleFonts.judson(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Quantity: ${sellInfo.quantity}",
                                style: GoogleFonts.judson(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text(
                                "Price: ₹${product.price}",
                                style: GoogleFonts.judson(
                                    textStyle: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              if (product.productimage != null &&
                                  product.productimage!.isNotEmpty)
                                SizedBox(
                                  width: 130,
                                  height: 150,
                                  child: ClipRRect(
                                    child: Image.file(
                                      File(product.productimage!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if (product.productimage == null ||
                                  product.productimage!.isEmpty)
                                Container(
                                  width: 130,
                                  height: 150,
                                  color: Colors.grey[
                                      300], // Adjusted for a more subtle background
                                  child: Icon(
                                    Icons.image,
                                    size: 50,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
