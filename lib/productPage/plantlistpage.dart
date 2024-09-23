import 'dart:io';

import 'package:cultiva/function/productpage/editproduct.dart';
import 'package:cultiva/function/productpage/editanddelete.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/productdetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Plantlistpage extends StatelessWidget {
  final String category;
  const Plantlistpage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant in $category'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Product>>(
        valueListenable: Hive.box<Product>('productBox').listenable(),
        builder: (context, productBox, child) {
          final List<Product> allProducts = productBox.values.toList();
          final List<Product> filteredProducts = allProducts
              .where((product) => product.producttype == category)
              .toList();

          int totalProductCount = filteredProducts.length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Products: $totalProductCount',
                  style: GoogleFonts.judson(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              filteredProducts.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('No products found in this category'),
                      ),
                    )
                  : Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Productdetails(product: product)));
                            },
                            child: Card(
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
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: const Color.fromARGB(
                                              255, 50, 126, 53),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "₹${product.price!}",
                                          style: GoogleFonts.judson(
                                              textStyle: TextStyle(
                                                  color: Colors.white)),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Editproduct(
                                                            product: product)));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          )),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title:
                                                        Text("Delete Product"),
                                                    content: Text(
                                                        "Are you sure you want to delete this product?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text("Cancel")),
                                                      TextButton(
                                                          onPressed: () {
                                                            deleteProduct(
                                                                product);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("Yes"))
                                                    ],
                                                  ));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
