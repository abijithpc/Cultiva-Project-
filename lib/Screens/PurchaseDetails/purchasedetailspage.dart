import 'package:cultiva/Screens/PurchaseDetails/Widget/purchasecustomerdetails.dart';
import 'package:cultiva/Screens/PurchaseDetails/Widget/purchaseproductdetails.dart';
import 'package:cultiva/Screens/PurchaseDetails/Widget/purchaseproductimage.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Purchasedetailspage extends StatelessWidget {
  final String customerName;
  final List<Sellinfo> customerSellInfo;

  const Purchasedetailspage(
      {super.key, required this.customerName, required this.customerSellInfo});

  @override
  Widget build(BuildContext context) {
    final productBox = Hive.box<Product>('productBox');
    final Sellinfo customerDetails = customerSellInfo.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Details",
          style: GoogleFonts.judson(
              textStyle:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'Assets/Backgroundimage/pexels-ian-panelo-3571551-min.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PurchaseCustomerDetail(customerDetails: customerDetails),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 152, 169, 152),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text("Purchased Product")),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerSellInfo.length,
                itemBuilder: (context, index) {
                  final sellInfo = customerSellInfo[index];
                  final product = productBox.values.firstWhere(
                      (prod) => prod.productname == sellInfo.product,
                      orElse: () => Product(
                            productname: 'productname',
                            description: 'description',
                            price: 'price',
                            productimage: '',
                            producttype: 'producttype',
                          ));

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E3311).withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              PurchaseProductImage(product: product),
                              const SizedBox(width: 20),
                              Expanded(
                                child: PurchaseProductDetails(
                                    product: product, sellInfo: sellInfo),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
