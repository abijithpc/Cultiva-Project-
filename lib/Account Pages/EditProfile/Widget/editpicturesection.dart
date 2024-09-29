// ignore_for_file: await_only_futures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditpictureSection extends StatelessWidget {
  final File? image;
  final Function(File) onImagePicked;

  const EditpictureSection({
    super.key,
    required this.image,
    required this.onImagePicked,
  });

  Future<void> editpickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(
          pickedFile.path)); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editpickImage,
      child: CircleAvatar(
        radius: 75,
        backgroundImage: image != null
            ? FileImage(image!)
            : AssetImage('Assets/profile.png') as ImageProvider,
        child: image == null
            ? Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }
}
