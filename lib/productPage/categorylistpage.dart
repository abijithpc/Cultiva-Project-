import 'package:cultiva/model/product.dart';
import 'package:cultiva/productPage/plantlistpage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Categorylistpage extends StatefulWidget {
  final List<String> categories;
  const Categorylistpage({super.key, required this.categories});

  @override
  State<Categorylistpage> createState() => _CategorylistpageState();
}

class _CategorylistpageState extends State<Categorylistpage> {
  late Box<Product> productBox;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    productBox = await Hive.openBox<Product>('categoryBox');
  }

  void _deleteCategory(String category) {
    setState(() {
      widget.categories.remove(category);
    });
    final products = productBox.values.toList();
    for (var product in products) {
      if (product.producttype == category) {
        productBox.delete(product.key);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'Assets/Backgroundimage/pexels-guihankenne-2792070-min.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(category),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _deleteCategory(category);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Plantlistpage(category: category),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
