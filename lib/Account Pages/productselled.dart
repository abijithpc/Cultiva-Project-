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
  String? selectedProduct;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController customernameCon = TextEditingController();
  final TextEditingController customerNumberCon = TextEditingController();
  final TextEditingController QuantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double Screenheigth = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Product Selled",
            style: GoogleFonts.judson(
                textStyle:
                    TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          centerTitle: true,
        ),
        body: Container(
          width: ScreenWidth,
          height: Screenheigth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Full Name")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: customernameCon,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Phone Number")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: customerNumberCon,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
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
                                      border: OutlineInputBorder()),
                                  items: products.map((product) {
                                    return DropdownMenuItem(
                                        value: product.productname,
                                        child: Text(product.productname!));
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
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text("Quantity")],
                          ),
                          SizedBox(
                            child: TextFormField(
                              controller: QuantityController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {},
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

  void SaveDetails() {
    if (_formKey.currentState!.validate()) {
      final sellinfo = Sellinfo(
          customerName: customernameCon.text,
          customerNumber: customerNumberCon.text,
          product: selectedProduct!,
          quantity: int.parse(QuantityController.text));
      final sellInfoBox = Hive.box<Sellinfo>('sellInfoBox');
      sellInfoBox.add(sellinfo);

      Navigator.pop(context);
    }
  }
}
