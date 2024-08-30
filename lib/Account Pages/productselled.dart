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
            onPressed: _showSelectedProductsDialog,
            icon: Icon(Icons.inventory),
          )
        ],
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        height: 9,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final box = await Hive.openBox<Sellinfo>('sellBox');
                          if (_formKey.currentState!.validate()) {
                            for (var product in selectedProducts) {
                              await saveDetails(
                                customerName: customernameCon.text,
                                customerNumber: customerNumberCon.text,
                                product: product['product'].productname!,
                                quantity: product['quantity'],
                                sellBox: box,
                              );
                            }

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
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 24)),
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

  void _showSelectedProductsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Calculate the total price of all selected products
            num totalPrice = selectedProducts.fold(0, (sum, item) {
              final product = item['product'];
              final quantity = item['quantity'];
              return sum + (int.parse(product.price!) * quantity);
            });

            return AlertDialog(
              title: Text('Selected Products'),
              content: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: selectedProducts.length,
                        itemBuilder: (context, index) {
                          final product = selectedProducts[index]['product'];
                          final quantity = selectedProducts[index]['quantity'];
                          final price = int.parse(product.price!) * quantity;

                          return ListTile(
                            title: Text(product.productname!),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Quantity: $quantity'),
                                Text('Total Price: ₹${price.toString()}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (selectedProducts[index]['quantity'] >
                                          1) {
                                        selectedProducts[index]['quantity']--;
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      selectedProducts[index]['quantity']++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Total Purchase Price: ₹${totalPrice.toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
