import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> editpickImage() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

  Widget tooglePassword(bool isSecurePassword, Function onTap) {
    return IconButton(
        onPressed: () {
          onTap();
        },
        icon: isSecurePassword
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }