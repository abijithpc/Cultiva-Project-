import 'package:cultiva/Screens/mainpage.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> checklogin(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController passwordController) async {
  final userBox = Hive.box<User>('userBox');
  final users = userBox.values;

  final username = usernameController.text;
  final passwords = passwordController.text;

  bool founduser = false;

  for (var user in users) {
    if (user.username == username && user.password == passwords) {
      founduser = true;

      final authBox = await Hive.openBox('authBox');
      await authBox.put(
          'currentUserIndex', userBox.keys.toList().indexOf(user.key));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const Mainpage(
                    sellinfo: null,
                    selectedProduct: null,
                  )),
          (route) => false);
      break;
    }
  }
  if (!founduser) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "Incorrect Password or Username",
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}
