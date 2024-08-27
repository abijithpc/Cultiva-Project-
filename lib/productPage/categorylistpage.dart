import 'package:cultiva/productPage/plantlistpage.dart';
import 'package:flutter/material.dart';

class Categorylistpage extends StatelessWidget {
  final List<String> categories;
  const Categorylistpage({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(categories[index]),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Plantlistpage(category: categories[index])));
              });
        },
      ),
    );
  }
}
