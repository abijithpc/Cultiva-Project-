import 'dart:io';

import 'package:cultiva/function/categoryfunction/addcategory.dart';
import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/categorylistpage.dart';
import 'package:cultiva/productPage/productdetails.dart';
import 'package:cultiva/widget/carousel2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

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
    final minPrice = double.tryParse(minpriceController.text) ?? 0;
    final maxPrice = double.tryParse(maxpriceController.text) ?? 0;

    setState(() {
      isSearching = query.isNotEmpty ||
          minpriceController.text.isNotEmpty ||
          maxpriceController.text.isNotEmpty;
      filteredProducts = allProducts.where((product) {
        final nameMatch =
            product.productname?.toLowerCase().contains(query) ?? false;
        final descriptionMatch =
            product.description?.toLowerCase().contains(query) ?? false;

        //converting the price String to double
        final double productPrice =
            double.tryParse(product.price?.toString() ?? '') ?? 0.0;

        //giving min and max value
        final double minPrice = 10.0;
        final double maxPrice = 100.0;

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
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GradientText(
            'Greening up my spaces',
            style: GoogleFonts.judson(
                textStyle: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            )),
            colors: [Colors.green, Color.fromARGB(255, 199, 194, 194)],
          ),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (text) {
                      filterProducts();
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(12)),
                        hintText: 'Search Plant',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.3)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 9),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: minpriceController,
                      decoration: InputDecoration(
                          labelText: 'Min Price',
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.3)),
                      keyboardType: TextInputType.number,
                    )),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: maxpriceController,
                      decoration: InputDecoration(
                          labelText: 'Max Price',
                          fillColor: Colors.grey.withOpacity(0.3),
                          filled: true),
                      keyboardType: TextInputType.number,
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              if (isSearching) ...[
                // Show search results if searching
                filteredProducts.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'No products found',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return ListTile(
                            leading: Image.file(
                              width: 60,
                              height: 120,
                              File(product.productimage!),
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.productname ?? 'No Name'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Productdetails(product: product)));
                            },
                          );
                        },
                      ),
              ] else ...[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Product Category",
                  style: GoogleFonts.judson(
                      textStyle:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      final newCategory = await showaddCategoryDialog(context);
                      if (newCategory != null && newCategory.isNotEmpty) {
                        final newProduct = Product(
                            producttype: newCategory,
                            productname: 'Default Name',
                            description: 'Default Description',
                            price: '0',
                            productimage: null);

                        final ProductBox = Hive.box<Product>('productBox');
                        ProductBox.add(newProduct);

                        loadProducts();
                        setState(() {});

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categorylistpage(
                                    categories: _getCategories()
                                      ..add(newCategory))));
                      }
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add category')),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categorylistpage(
                                  categories: _getCategories())));
                    },
                    icon: Icon(Icons.category),
                    label: Text('View Categories'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(child: Carousel2()),
              ]
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getCategories() {
    final categoris = allProducts
        .map((product) => product.producttype ?? '')
        .toSet()
        .toList();
    return categoris;
  }
}