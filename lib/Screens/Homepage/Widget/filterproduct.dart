import 'package:flutter/material.dart';

class FliteringProducts extends StatelessWidget {
  const FliteringProducts({
    super.key,
    required this.minpriceController,
    required this.maxpriceController,
  });

  final TextEditingController minpriceController;
  final TextEditingController maxpriceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 9),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: minpriceController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                hintText: 'Min Price',
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 253, 253)
                    .withOpacity(0.3)),
            keyboardType: TextInputType.number,
          )),
          SizedBox(
            width: 18,
          ),
          Expanded(
              child: TextFormField(
            controller: maxpriceController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12)),
                hintText: 'Max Price',
                hintStyle: TextStyle(color: Colors.white),
                fillColor: const Color.fromARGB(255, 255, 254, 254)
                    .withOpacity(0.3),
                filled: true),
            keyboardType: TextInputType.number,
          ))
        ],
      ),
    );
  }
}