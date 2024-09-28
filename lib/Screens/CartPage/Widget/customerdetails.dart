import 'package:cultiva/function/dateformat.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerDetails extends StatelessWidget {
  const CustomerDetails({
    super.key,
    required this.customerSellInfo,
    required this.totalPriceCustomer,
  });

  final List<Sellinfo> customerSellInfo;
  final double totalPriceCustomer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${customerSellInfo.first.customerName ?? 'Unknown'}',
          style: GoogleFonts.judson(
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        Text(
          'PhoneNumber: ${customerSellInfo.first.customerNumber ?? 'Unknown'}',
          style: GoogleFonts.judson(
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        Text(
          'Date:${customerSellInfo.first.sellDate != null ? formatDate(customerSellInfo.first.sellDate!) : 'No Date'}',
          style: GoogleFonts.judson(
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        Text(
          'Total Price: ₹${totalPriceCustomer.toStringAsFixed(2)}',
          style: GoogleFonts.judson(
              textStyle:
                  TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}