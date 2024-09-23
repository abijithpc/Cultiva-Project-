import 'dart:io';

import 'package:cultiva/function/categoryfunction/addcategory.dart';
import 'package:cultiva/function/getCategory/getcategory.dart';
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
        final pricMatch = productPrice >= minPrice && productPrice <= maxPrice;

        return (nameMatch || descriptionMatch) && pricMatch;
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight * 1,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'Assets/Backgroundimage/plant-phone-cfbq4km7t75tc4wi.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Search Plant',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.3)),
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
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = filteredProducts[index];
                          return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.4)),
                            child: ListTile(
                              leading: product.productimage != null
                                  ? Image.file(
                                      width: 60,
                                      height: 120,
                                      File(product.productimage!),
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      width: 60,
                                      height: 120,
                                      color: Colors.grey,
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                              title: Text(product.productname ?? 'No Name'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Productdetails(product: product)));
                              },
                            ),
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
                      textStyle: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      final newCategory = await showaddCategoryDialog(context);
                      if (newCategory != null && newCategory.isNotEmpty) {
                        final newProduct = Product(
                            producttype: newCategory,
                            productname: 'Default Name',
                            description: 'Default Description',
                            price: '0',
                            productimage: null);

                        final productBox = Hive.box<Product>('productBox');
                        productBox.add(newProduct);

                        loadProducts();
                        setState(() {});

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categorylistpage(
                                    categories: categoryProvider.getCategories()
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
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categorylistpage(
                                  categories:
                                      categoryProvider.getCategories())));
                    },
                    icon: Icon(Icons.category_outlined),
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
}
