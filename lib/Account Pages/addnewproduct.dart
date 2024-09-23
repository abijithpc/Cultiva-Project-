// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:cultiva/function/addnewproduct/addnewproductfuntion.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class Addnewproduct extends StatefulWidget {
  final List<String> categories;
  const Addnewproduct({super.key, required this.categories});

  @override
  State<Addnewproduct> createState() => _AddnewproductState();
}

class _AddnewproductState extends State<Addnewproduct> {
  String? _selectCategory;
  List<String> _categories = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController productController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ProductquantityController = TextEditingController();
  File? _selectedProductImage;
  List<Product> allProducts = [];

  @override
  void initState() {
    super.initState();

    void loadProducts() {
      final productBox = Hive.box<Product>('productBox');
      setState(() {
        allProducts = productBox.values.toList();
        _categories = getCategories(allProducts);
        _selectCategory = _categories.isNotEmpty ? _categories[0] : null;
      });
    }

    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Product",
            style: GoogleFonts.judson(
              textStyle: const TextStyle(fontSize: 25),
            ),
          ),
          centerTitle: true,
        ),
        body: Scaffold(
          body: SizedBox(
            height: screenheigth * 1,
            width: screenwidth,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final pickedImage = await pickImage();
                          setState(() {
                            _selectedProductImage = pickedImage;
                          });
                        },
                        child: ClipRRect(
                            child: _selectedProductImage != null
                                ? Image.file(
                                    _selectedProductImage!,
                                    width: screenwidth,
                                    height: screenheigth * 0.2,
                                  )
                                : Image.asset(
                                    'Assets/add-image-photo-icon.png',
                                    width: screenwidth,
                                    height: screenheigth * 0.2,
                                    fit: BoxFit.contain,
                                  )),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: productController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.perm_contact_calendar),
                                hintText: "Product Name",
                                hintStyle: GoogleFonts.judson(
                                  textStyle: const TextStyle(fontSize: 17),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "ProductName Field is Required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: _selectCategory,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.type_specimen),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                              ),
                              hint: Text(
                                "Plant Type",
                                style: GoogleFonts.judson(
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                              ),
                              items: _categories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectCategory = newValue!;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.currency_rupee),
                                hintText: "Price",
                                hintStyle: GoogleFonts.judson(
                                  textStyle: const TextStyle(fontSize: 17),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Price Field is Required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: descriptionController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 2,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.description),
                                hintText: "Description",
                                hintStyle: GoogleFonts.judson(
                                  textStyle: const TextStyle(fontSize: 17),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Description Field is Required";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: ProductquantityController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.numbers),
                                  hintText: "Product Quantity",
                                  hintStyle: GoogleFonts.judson(
                                    textStyle: const TextStyle(fontSize: 17),
                                  ),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                addProduct(
                                    context: context,
                                    formKey: _formKey,
                                    productController: productController,
                                    priceController: priceController,
                                    descriptionController:
                                        descriptionController,
                                    selectCategory: _selectCategory!,
                                    selectedProductImage: _selectedProductImage,
                                    productQuantityController:
                                        ProductquantityController);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 23, 65, 24),
                                minimumSize: const Size(400, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                "Add Product",
                                style: GoogleFonts.judson(
                                  textStyle: const TextStyle(
                                      fontSize: 23, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
