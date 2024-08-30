import 'package:cultiva/model/sellinfo.dart';
import 'package:flutter/material.dart';

class Purchasedetailspage extends StatelessWidget {
  final Sellinfo sellinfo;
  final List<Map<String, dynamic>> selectedProducts;
  const Purchasedetailspage(
      {Key? key, required this.selectedProducts, required this.sellinfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
