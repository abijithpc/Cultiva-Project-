import 'package:cultiva/Screens/Homepage/Widget/addcategorybutton.dart';
import 'package:cultiva/Screens/Homepage/Widget/filterproduct.dart';
import 'package:cultiva/Screens/Homepage/Widget/header.dart';
import 'package:cultiva/Screens/Homepage/Widget/productcategory.dart';
import 'package:cultiva/Screens/Homepage/Widget/productlist.dart';
import 'package:cultiva/Screens/Homepage/Widget/searchbar.dart';
import 'package:cultiva/Screens/Homepage/Widget/viewcategorybutton.dart';
import 'package:cultiva/function/getCategory/getcategory.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/widget/carousel2.dart';
import 'package:flutter/material.dart';

class HomepageBody extends StatelessWidget {
  final TextEditingController searchController;
  final TextEditingController minpriceController;
  final TextEditingController maxpriceController;
  final List<Product> filteredProducts;
  final bool isSearching;
  final CategoryProvider categoryProvider;
  final Function loadProducts;

  const HomepageBody({
    Key? key,
    required this.searchController,
    required this.minpriceController,
    required this.maxpriceController,
    required this.filteredProducts,
    required this.isSearching,
    required this.categoryProvider,
    required this.loadProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Header(),
          Searchbar(searchController: searchController),
          FliteringProducts(
            minpriceController: minpriceController,
            maxpriceController: maxpriceController,
          ),
          if (isSearching)
            ProductList(filteredProducts: filteredProducts)
          else ...[
            ProductCategoryHeader(),
            AddCategoryButton(
              categoryProvider: categoryProvider,
              loadProducts: loadProducts,
            ),
            SizedBox(
              height: 10,
            ),
            ViewCategoryBtn(categoryProvider: categoryProvider),
            SizedBox(height: 20),
            Carousel2(),
          ],
        ],
      ),
    );
  }
}
