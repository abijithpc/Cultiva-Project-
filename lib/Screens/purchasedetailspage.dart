import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Purchasedetailspage extends StatelessWidget {
  final Sellinfo sellinfo;
  const Purchasedetailspage({Key? key, required this.sellinfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
              color: Colors.blueGrey[300],
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CustomerName: ${sellinfo.customerName}',
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'CustomerNumber: ${sellinfo.customerNumber}',
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'Product Name: ${sellinfo.product}',
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'Quantity: ${sellinfo.quantity}',
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                'Price: ${sellinfo.totalPrice}',
                style: GoogleFonts.judson(
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 9,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
