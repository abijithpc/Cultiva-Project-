import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Addnewproduct extends StatefulWidget {
  const Addnewproduct({super.key});

  @override
  State<Addnewproduct> createState() => _AddnewproductState();
}

class _AddnewproductState extends State<Addnewproduct> {
  String? _selectCategory;
  final _formKey = GlobalKey<FormState>();
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();
  File? _selectedProductImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedProductImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _addproduct() async {
    if (_formKey.currentState!.validate()) {
      final ProductName = ProductNameController.text;
      final Price = PriceController.text;
      final Description = DescriptionController.text;

      final prduct = Product(
          productname: ProductName,
          description: Description,
          price: Price,
          productimage: _selectedProductImage != null
              ? _selectedProductImage!.path
              : null,
          producttype: _selectCategory!);

      var box = Hive.box<Product>('productBox');
      await box.add(prduct);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Product Addedd Successfully')));

      ProductNameController.clear();
      PriceController.clear();
      DescriptionController.clear();
      setState(() {
        _selectCategory = null;
        _selectedProductImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Product",
            style: GoogleFonts.judson(
              textStyle: TextStyle(fontSize: 25),
            ),
          ),
          centerTitle: true,
        ),
        body: Scaffold(
          body: SizedBox(
            height: Screenheigth * 1,
            width: ScreenWidth,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: ClipRRect(
                            child: _selectedProductImage != null
                                ? Image.file(
                                    _selectedProductImage!,
                                    width: ScreenWidth,
                                    height: Screenheigth * 0.2,
                                  )
                                : Image.asset(
                                    'Assets/profile.png',
                                    width: ScreenWidth,
                                    height: Screenheigth * 0.2,
                                    fit: BoxFit.cover,
                                  )),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: ProductNameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
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
                              items: <String>[
                                'Indoor',
                                'Outdoor'
                              ].map<DropdownMenuItem<String>>((String value) {
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
                              controller: PriceController,
                              decoration: InputDecoration(
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
                              controller: DescriptionController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              maxLines: 2,
                              decoration: InputDecoration(
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
                                Navigator.pop(context);
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
