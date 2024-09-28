import 'package:cultiva/function/categoryfunction/addcategory.dart';
import 'package:cultiva/function/getCategory/getcategory.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/categorylistpage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCategoryButton extends StatelessWidget {
  final CategoryProvider categoryProvider;
  final Function loadProducts;

  const AddCategoryButton({
    Key? key,
    required this.categoryProvider,
    required this.loadProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        final newCategory = await showaddCategoryDialog(context);
        if (newCategory != null && newCategory.isNotEmpty) {
          final newProduct = Product(
            producttype: newCategory,
            productname: 'Default Name',
            description: 'Default Description',
            price: '0',
            productimage: null,
          );

          final productBox = Hive.box<Product>('productBox');
          productBox.add(newProduct);

          loadProducts();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Categorylistpage(
                categories: categoryProvider.getCategories()
                  ..add(newCategory),
              ),
            ),
          );
        }
      },
      icon: Icon(Icons.add),
      label: Text('Add category'),
    );
  }
}
