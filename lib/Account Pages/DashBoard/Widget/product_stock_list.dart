import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';

class ProductStockList extends StatelessWidget {
  // ignore: use_super_parameters
  const ProductStockList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Product>>(
      valueListenable: Hive.box<Product>('productBox').listenable(),
      builder: (context, productBox, _) {
        final products = productBox.values.toList();
        final sellInfos = Hive.box<Sellinfo>('sellBox').values.toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            final totalSold = sellInfos
                .where((sellInfo) => sellInfo.product == product.productname)
                .fold(0, (sum, sellInfo) => sum + (sellInfo.quantity ?? 0));

            final initialStock = num.tryParse(
                    product.productQuantity?.toString() ?? '0') ??
                0;
            return ListTile(
              title: Text(product.productname ?? "Unnamed Product"),
              subtitle: Text("Stock: ${initialStock - totalSold} / $initialStock"),
              trailing: Text("Price: ${product.price}"),
            );
          },
        );
      },
    );
  }
}
