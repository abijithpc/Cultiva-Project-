import 'package:cultiva/function/getCategory/getcategory.dart';
import 'package:cultiva/productPage/categorylistpage.dart';
import 'package:flutter/material.dart';

class ViewCategoryBtn extends StatelessWidget {
  final CategoryProvider categoryProvider;

  const ViewCategoryBtn({
    Key? key,
    required this.categoryProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categorylistpage(
              categories: categoryProvider.getCategories(),
            ),
          ),
        );
      },
      child: Text('View Categories'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
