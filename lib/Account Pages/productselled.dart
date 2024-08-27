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
  final TextEditingController QuantityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final List<Sellinfo> sellInfotlist = [];

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
        ),
        body: SizedBox(
          width: screenWidth,
          height: screenheigth,
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Full Name")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: customernameCon,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
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
                            height: 9,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Phone Number")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: customerNumberCon,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
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
                            height: 9,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Select Product"),
                            ],
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
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      border: const OutlineInputBorder()),
                                  items: products.map((product) {
                                    return DropdownMenuItem(
                                      value: product.productname,
                                      child: Text(product.productname!),
                                      onTap: () {
                                        selectedproductPrice = product.price;
                                        selectedImagePath =
                                            product.productimage;
                                        selectedProductObject = product;
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedProduct = value;
                                    });
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
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Quantity")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: QuantityController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  border: OutlineInputBorder()),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "PhoneNumber Field is Required";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final box =
                                  await Hive.openBox<Sellinfo>('sellBox');
                              if (_formKey.currentState!.validate()) {
                                await saveDetails(
                                    customerName: customernameCon.text,
                                    customerNumber: customerNumberCon.text,
                                    product: selectedProduct!,
                                    quantity:
                                        int.parse(QuantityController.text),
                                    sellBox: box);

                                Navigator.pop(context);
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
                  )),
            ),
          ),
        ));
  }
}
