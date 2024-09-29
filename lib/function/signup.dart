import 'package:cultiva/Screens/LoginPage/loginpage.dart';
import 'package:cultiva/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignupHelper {
  Future<void> saveData(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController numbercontroller,
      GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      final userBox = Hive.box<User>("userBox");
      final users = User(
        username: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phonenumber: int.tryParse(numbercontroller.text) ?? 0,
      );
      await userBox.add(users);

      final authBox = await Hive.openBox('authBox');
      await authBox.put('isLoggedIn', true);

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      numbercontroller.clear();

      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    }
  }
}
