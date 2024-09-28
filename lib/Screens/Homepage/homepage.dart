import 'package:cultiva/Screens/Homepage/Widget/homepagebody.dart';
import 'package:cultiva/function/getCategory/getcategory.dart';
import 'package:cultiva/model/product.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController searchController = TextEditingController();
  TextEditingController minpriceController = TextEditingController();
  TextEditingController maxpriceController = TextEditingController();
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    loadProducts();

    searchController.addListener(() {
      filterProducts();
    });
    minpriceController.addListener(() {
      filterProducts();
    });
    maxpriceController.addListener(() {
      filterProducts();
    });
  }

  void loadProducts() {
    final productBox = Hive.box<Product>('productBox');
    setState(() {
      allProducts = productBox.values.toList();
      filteredProducts = allProducts;
    });
  }

  void filterProducts() {
    final query = searchController.text.toLowerCase();
    final minPrice = double.tryParse(minpriceController.text) ?? 0.0;
    final maxPrice =
        double.tryParse(maxpriceController.text) ?? double.infinity;

    setState(() {
      isSearching = query.isNotEmpty ||
          minpriceController.text.isNotEmpty ||
          maxpriceController.text.isNotEmpty;
      filteredProducts = allProducts.where((product) {
        final nameMatch =
            product.productname?.toLowerCase().contains(query) ?? false;
        final descriptionMatch =
            product.description?.toLowerCase().contains(query) ?? false;
        final double productPrice = double.tryParse(product.price ?? '') ?? 0.0;
        final priceMatch = productPrice >= minPrice && productPrice <= maxPrice;

        return (nameMatch || descriptionMatch) && priceMatch;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = CategoryProvider();
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'Assets/Backgroundimage/plant-phone-cfbq4km7t75tc4wi.jpg',
                ),
                fit: BoxFit.cover)),
        child: HomepageBody(
          searchController: searchController,
          minpriceController: minpriceController,
          maxpriceController: maxpriceController,
          filteredProducts: filteredProducts,
          isSearching: isSearching,
          categoryProvider: categoryProvider,
          loadProducts: loadProducts,
        ),
      ),
    );
  }
}
