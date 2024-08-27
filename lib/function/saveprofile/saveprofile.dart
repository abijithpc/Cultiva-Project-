import 'dart:io';

import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> saveProfile(
    User user,
    TextEditingController editusername,
    TextEditingController editPhonenumber,
    TextEditingController editEmail,
    TextEditingController editPassword,
    File? image,
    BuildContext context) async {
  final box = await Hive.openBox<User>('UserBox');
  final index = box.values.toList().indexOf(user);

  if (index != -1) {
    User updatedUser = user
      ..username = editusername.text
      ..phonenumber = int.tryParse(editPhonenumber.text) ?? 0
      ..email = editEmail.text
      ..password = editPassword.text
      ..profileImage = image?.path;

    await box.putAt(index, updatedUser);

    Navigator.pop(context);
  }
}
