import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.customerSellInfo,
    required this.productBox,
  });

  final List<Sellinfo> customerSellInfo;
  final Box<Product> productBox;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: customerSellInfo.map((sellInfo) {
        final product =
            productBox.values.firstWhere(
          (prod) =>
              prod.productname == sellInfo.product,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.productname ?? 'Unknown',
                  style: GoogleFonts.judson(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                    'Quantity: ${sellInfo.quantity}'),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}