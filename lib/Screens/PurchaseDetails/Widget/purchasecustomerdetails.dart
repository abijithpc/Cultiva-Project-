import 'package:cultiva/function/dateformat.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseCustomerDetail extends StatelessWidget {
  const PurchaseCustomerDetail({
    super.key,
    required this.customerDetails,
  });

  final Sellinfo customerDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 152, 169, 152),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Customer Details",
              style: GoogleFonts.judson(
                  textStyle: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Text('Name: ${customerDetails.customerName ?? 'Unknown'}'),
            Text('Number: ${customerDetails.customerNumber ?? 'Unknown'}'),
            Text('Date: ${formatDate(DateTime.now())}')
          ],
        ),
      ),
    );
  }
}
