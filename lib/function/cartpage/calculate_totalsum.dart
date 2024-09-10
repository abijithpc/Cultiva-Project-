import 'package:cultiva/model/product.dart';
import 'package:cultiva/model/sellinfo.dart';
import 'package:hive/hive.dart';

double calculateTotalPriceForAllCustomer(
    List<Sellinfo> customerSellInfo, Box<Product> productBox) {
  double totalPrice = 0.0;

  for (var sellInfo in customerSellInfo) {
    final product = productBox.values.firstWhere(
      (prod) => prod.productname == sellInfo.product,
      orElse: () => Product(
          productname: 'productname',
          description: 'description',
          price: '0',
          productimage: 'productimage',
          producttype: 'producttype'),
    );
    totalPrice += (double.tryParse(product.price!) ?? 0.0) * sellInfo.quantity!;
  }
  return totalPrice;
}
