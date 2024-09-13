import 'package:flutter/material.dart';

Future<void> showEditProductDialog(
  BuildContext context,
  TextEditingController editController,
  ValueChanged<int> onSave,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Edit Total Product"),
        content: TextField(
          controller: editController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "Enter new total product"),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                final newValue = int.tryParse(editController.text) ?? 0;
                onSave(newValue);
                Navigator.of(context).pop();
              },
              child: Text("Save"))
        ],
      );
    },
  );
}
