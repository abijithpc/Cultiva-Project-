// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:cultiva/function/addproduct/addproduct.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

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
  File? _selectedProductImage;
  List<Product> allProducts = [];

  @override
  void initState() {
    super.initState();

    void loadProducts() {
      final productBox = Hive.box<Product>('productBox');
      setState(() {
        allProducts = productBox.values.toList();
        _categories =
            _getCategories(); // Populate categories after loading products
        _selectCategory = _categories.isNotEmpty
            ? _categories[0]
            : null; // Set default value if necessary
      });
    }

    loadProducts(); // Load products and then populate categories
  }

  List<String> _getCategories() {
    final categories = allProducts
        .map((product) => product.producttype ?? '')
        .where((type) => type.isNotEmpty) // Exclude empty strings
        .toSet()
        .toList();
    return categories;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedProductImage = File(pickedFile.path);
      });
    }
  }

  void _addproduct() async {
    if (_formKey.currentState!.validate()) {
      final productName = productController.text;
      final price = priceController.text;
      final description = descriptionController.text;
      final productType = _selectCategory!;

      await Addproduct().addProduct(
          context: context,
          productName: productName,
          price: price,
          description: description,
          productType: productType,
          productImage: _selectedProductImage);

      productController.clear();
      priceController.clear();
      descriptionController.clear();
      setState(() {
        _selectCategory = null;
        _selectedProductImage = null;
      });
      Navigator.pop(context);
    }
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: ClipRRect(
                            child: _selectedProductImage != null
                                ? Image.file(
                                    _selectedProductImage!,
                                    width: screenwidth,
                                    height: screenheigth * 0.2,
                                  )
                                : Image.asset(
                                    'Assets/profile.png',
                                    width: screenwidth,
                                    height: screenheigth * 0.2,
                                    fit: BoxFit.cover,
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
                            ElevatedButton(
                              onPressed: () {
                                _addproduct();
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
