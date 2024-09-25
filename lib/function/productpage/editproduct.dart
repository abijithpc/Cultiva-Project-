import 'dart:io';

import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class Editproduct extends StatefulWidget {
  final Product product;
  const Editproduct({super.key, required this.product});

  @override
  State<Editproduct> createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController typeController;
  late TextEditingController descriptionController;
  late TextEditingController productQuantityController;
  File? image;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.productname);
    descriptionController =
        TextEditingController(text: widget.product.description);
    productQuantityController =
        TextEditingController(text: widget.product.productQuantity.toString());
    priceController =
        TextEditingController(text: widget.product.price.toString());

    typeController = TextEditingController(text: widget.product.producttype);
    image = widget.product.productimage != null
        ? File(widget.product.productimage!)
        : null;
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  void saveProduct() {
    final box = Hive.box<Product>('productBox');
    widget.product.productname = nameController.text;
    widget.product.price = priceController.text;
    widget.product.producttype = typeController.text;
    widget.product.productimage = image?.path;
    widget.product.description = descriptionController.text;
    widget.product.productQuantity = productQuantityController.text;

    box.put(widget.product.key, widget.product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
        actions: [IconButton(onPressed: saveProduct, icon: Icon(Icons.save))],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImage,
                child: image != null
                    ? Image.file(
                        image!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'Assets/PlantsImage/nick-hillier-AhAxCcVajHk-unsplash.jpg',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.perm_identity),
                    labelText: 'Product Name',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.currency_rupee),
                    labelText: 'Product price',
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: productQuantityController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Product Quantity',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: typeController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.type_specimen),
                    labelText: 'Product Type',
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description),
                    labelText: 'Product Description',
                    border: OutlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
