import 'package:flutter/material.dart';

Future<String?> showaddCategoryDialog(BuildContext context) async {
  TextEditingController categoryController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add new category'),
        content: TextField(
          controller: categoryController,
          decoration: InputDecoration(hintText: 'Enter category name'),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(categoryController.text);
              },
              child: Text('Add')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"))
        ],
      );
    },
  );
}
