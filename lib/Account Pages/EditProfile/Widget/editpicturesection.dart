import 'dart:io';

import 'package:cultiva/function/profile/edit_profile/edit_profile.dart';
import 'package:flutter/material.dart';

class EditpictureSection extends StatelessWidget {
  const EditpictureSection({
    super.key,
    required File? image,
  }) : _image = image;

  final File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: editpickImage,
      child: CircleAvatar(
        radius: 75,
        backgroundImage: _image != null
            ? FileImage(_image!)
            : AssetImage('Assets/profile.png') as ImageProvider,
        child: _image == null
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