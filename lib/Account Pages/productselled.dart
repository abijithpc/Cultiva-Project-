import 'dart:developer';

import 'package:cultiva/Screens/mainpage.dart';
import 'package:cultiva/function/productselled/showselectedproductdata.dart';
import 'package:cultiva/function/savedetails/savedetails.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Productselled extends StatefulWidget {
  const Productselled({super.key});

  @override
  State<Productselled> createState() => _ProductselledState();
}

class _ProductselledState extends State<Productselled> {
  Product? selectedProductObject;
  String? selectedProduct;
  String? selectedproductPrice;
  String? selectedImagePath;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController customernameCon = TextEditingController();
  final TextEditingController customerNumberCon = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final List<Sellinfo> sellInfotlist = [];
  final List<Map<String, dynamic>> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Selled",
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showSelectedProductsDialog(
                context, selectedProducts, customernameCon, customernameCon),
            icon: Icon(Icons.inventory),
          )
        ],
      ),
      body: Container(
        width: screenWidth,
        height: screenheigth,
        
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Assets/Backgroundimage/pexels-rickyrecap-2560898-min.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: customernameCon,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: "Full Name",
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                border: const OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Name Field Is Required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: customerNumberCon,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                labelText: "Phone Number",
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.7),
                                border: const OutlineInputBorder()),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "PhoneNumber Field is Required";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<Product>('productBox').listenable(),
                            builder: (context, Box<Product> box, _) {
                              final products = box.values.toList();
                              return DropdownButtonFormField<String>(
                                value: selectedProduct,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.select_all_sharp),
                                    labelText: "Select Product",
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.7),
                                    border: const OutlineInputBorder()),
                                items: products.map((product) {
                                  return DropdownMenuItem(
                                    value: product.productname,
                                    child: Text(product.productname!),
                                    onTap: () {
                                      selectedproductPrice = product.price;
                                      selectedImagePath = product.productimage;
                                      selectedProductObject = product;
                                    },
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedProduct = value;
                                  });
                                  _addProductToSelection();
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please Select Product";
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              final box =
                                  await Hive.openBox<Sellinfo>('sellBox');
                              if (_formKey.currentState!.validate()) {
                                for (var product in selectedProducts) {
                                  await saveDetails(
                                    customerName: customernameCon.text,
                                    customerNumber: customerNumberCon.text,
                                    product: product['product'].productname!,
                                    quantity: product['quantity'],
                                    totalPrice: selectedProducts.fold(
                                      0,
                                      (sum, item) {
                                        final product = item['product'];
                                        final quantity = item['quantity'];
                                        return sum +
                                            (int.parse(product.price!) *
                                                quantity);
                                      },
                                    ),
                                    sellBox: box,
                                  );
                                }
                                if (!mounted) return;
                                log("data saved....");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Details Added Successfully')));

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Mainpage(),
                                    ));
                              }
                            } catch (e) {
                              log("error : === $e");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 23, 65, 24),
                              minimumSize: Size(300, 60),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            "Save Details",
                            style: GoogleFonts.judson(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addProductToSelection() {
    if (selectedProductObject != null) {
      setState(() {
        selectedProducts.add({
          'product': selectedProductObject!,
          'quantity': 1, // Default quantity
        });
      });
    }
  }
}
