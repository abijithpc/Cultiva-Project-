import 'package:cultiva/Screens/CartPage/Widget/customerdetails.dart';
import 'package:cultiva/Screens/CartPage/Widget/finaltotalprice.dart';
import 'package:cultiva/Screens/CartPage/Widget/productdetails.dart';
import 'package:cultiva/Screens/PurchaseDetails/purchasedetailspage.dart';
import 'package:cultiva/function/cartpage/calculate_totalsum.dart';
import 'package:cultiva/function/cartpage/calculatetotalquatity.dart';
import 'package:cultiva/function/cartpage/deletesellinfo.dart';
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
  double finalTotalPrice = 0;

  @override
  void initState() {
    super.initState();
    sellInfoBox = Hive.box<Sellinfo>('sellBox');
    productBox = Hive.box<Product>('productBox');
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('Assets/Backgroundimage/plant-phone.jpg'),
                fit: BoxFit.cover)),
        child: ValueListenableBuilder(
          valueListenable: sellInfoBox.listenable(),
          builder: (context, Box<Sellinfo> sellBox, _) {
            final sellInfoList = sellBox.values.toList();

            final Map<String, List<Sellinfo>> groupedSellInfo = {};
            for (var sellInfo in sellInfoList.reversed) {
              if (groupedSellInfo.containsKey(sellInfo.customerName)) {
                groupedSellInfo[sellInfo.customerName!]!.add(sellInfo);
              } else {
                groupedSellInfo[sellInfo.customerName!] = [sellInfo];
              }
            }

            final List<String> customerNames = groupedSellInfo.keys.toList();

            // Reset final total price
            finalTotalPrice = 0;

            // Precalculate the total price for all customers
            for (var customerName in customerNames) {
              final customerSellInfo = groupedSellInfo[customerName]!;
              final totalPriceCustomer = calculateTotalPriceForAllCustomer(
                  customerSellInfo, productBox);
              finalTotalPrice += totalPriceCustomer;
            }

            final totalQuantity = calculateTotalQuantity(groupedSellInfo);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: customerNames.length,
                    itemBuilder: (context, index) {
                      final customerName = customerNames[index];
                      final customerSellInfo = groupedSellInfo[customerName]!;

                      final totalPriceCustomer =
                          calculateTotalPriceForAllCustomer(
                              customerSellInfo, productBox);

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
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 500,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomerDetails(
                                        customerSellInfo: customerSellInfo,
                                        totalPriceCustomer: totalPriceCustomer),
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
                                                  deleteSellInfo(sellInfoBox,
                                                      customerName);
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
                                ProductDetails(
                                    customerSellInfo: customerSellInfo,
                                    productBox: productBox),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                FinalTotalPrice(
                    finalTotalPrice: finalTotalPrice,
                    totalQuantity: totalQuantity),
              ],
            );
          },
        ),
      ),
    );
  }
}
