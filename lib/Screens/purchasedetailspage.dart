import 'dart:io';

import 'package:cultiva/function/dateformat.dart';
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
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'Assets/Backgroundimage/pexels-ian-panelo-3571551.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 152, 169, 152),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Details",
                        style: GoogleFonts.judson(
                            textStyle: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Name: ${customerDetails.customerName ?? 'Unknown'}'),
                      Text(
                          'Number: ${customerDetails.customerNumber ?? 'Unknown'}'),
                      Text('Date: ${formatDate(DateTime.now())}')
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 152, 169, 152),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("Purchased Product")),
              ),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E3311).withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: product.productimage != null &&
                                        product.productimage!.isNotEmpty
                                    ? Image.file(
                                        File(product.productimage!),
                                        width: 130,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        width: 130,
                                        height: 150,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image,
                                          size: 50,
                                        ),
                                      ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.productname ?? 'Product Name',
                                      style: GoogleFonts.judson(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Product Type: ${product.producttype}",
                                      style: GoogleFonts.judson(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Quantity: ${sellInfo.quantity}",
                                      style: GoogleFonts.judson(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Price: ₹${product.price}",
                                      style: GoogleFonts.judson(
                                          textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}
