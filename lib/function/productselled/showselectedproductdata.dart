import 'package:flutter/material.dart';

void showSelectedProductsDialog(
  BuildContext context,
  List<Map<String, dynamic>> selectedProducts,
  TextEditingController customernameCon,
  TextEditingController customerNumberCon,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          num totalPrice = selectedProducts.fold(0, (sum, item) {
            final product = item['product'];
            final quantity = item['quantity'];
            return sum + (int.parse(product.price!) * quantity);
          });

          return AlertDialog(
            title: Text('Selected Products'),
            content: SizedBox(
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
                                    if (selectedProducts[index]['quantity'] > 1) {
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
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    selectedProducts.removeAt(index);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
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
