import 'package:cultiva/Screens/purchasedetailspage.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  late Box<Sellinfo> sellInfoBox;
  late Box<Product> productBox;

  @override
  void initState() {
    super.initState();
    sellInfoBox = Hive.box<Sellinfo>('sellBox');
    productBox = Hive.box<Product>('productBox');
  }

  void deleteSellInfo(String customerName) {
    setState(() {
      final entriesToDelete = sellInfoBox.values
          .where((sellInfo) => sellInfo.customerName == customerName)
          .toList();
      for (var sellInfo in entriesToDelete) {
        sellInfoBox.delete(sellInfo.key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sell Details",
          style: GoogleFonts.judson(
            textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: sellInfoBox.listenable(),
        builder: (context, Box<Sellinfo> sellBox, _) {
          final sellInfoList = sellBox.values.toList();

          // Grouping sellInfoList by customerName
          final Map<String, List<Sellinfo>> groupedSellInfo = {};
          for (var sellInfo in sellInfoList) {
            if (groupedSellInfo.containsKey(sellInfo.customerName)) {
              groupedSellInfo[sellInfo.customerName]!.add(sellInfo);
            } else {
              groupedSellInfo[sellInfo.customerName!] = [sellInfo];
            }
          }

          final List<String> customerNames = groupedSellInfo.keys.toList();

          return ListView.builder(
            itemCount: customerNames.length,
            itemBuilder: (context, index) {
              final customerName = customerNames[index];
              final customerSellInfo = groupedSellInfo[customerName]!;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Purchasedetailspage(
                        customerName: customerName,
                        customerSellInfo: customerSellInfo,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 226, 226, 226),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 500,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name: ${customerSellInfo.first.customerName ?? 'customerName'}',
                                  style: GoogleFonts.judson(
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Text(
                                  'PhoneNumber: ${customerSellInfo.first.customerNumber ?? 'customerNumber'}',
                                  style: GoogleFonts.judson(
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Text(
                                  'Date: ${DateTime.now().toString().split(' ')[0]}',
                                  style: GoogleFonts.judson(
                                    textStyle: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Delete Products"),
                                    content: Text(
                                        "Are you sure you want to delete all products for this customer?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteSellInfo(customerName);
                                          Navigator.pop(context);
                                        },
                                        child: Text("Yes"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: Colors.black),
                        Column(
                          children: customerSellInfo.map((sellInfo) {
                            final product = productBox.values.firstWhere(
                              (prod) => prod.productname == sellInfo.product,
                              orElse: () => Product(
                                productname: 'Unknown',
                                description: 'description',
                                price: '0',
                                productimage: '',
                                producttype: 'Unknown',
                              ),
                            );
                            return Row(
                              children: [
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      product.productname ?? 'Product name',
                                      style: GoogleFonts.judson(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   "₹${product.price}",
                                    //   style: GoogleFonts.judson(
                                    //     textStyle: TextStyle(
                                    //       fontSize: 25,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
