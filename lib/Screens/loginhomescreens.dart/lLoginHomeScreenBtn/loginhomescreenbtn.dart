// ignore_for_file: file_names

import 'package:cultiva/Screens/LoginPage/loginpage.dart';
import 'package:cultiva/Screens/Signup/signup.dart';
import 'package:flutter/material.dart';

class LoginHomseScreenBtn extends StatelessWidget {
  const LoginHomseScreenBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40), // Adjusted for balance
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Loginpage(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            minimumSize: const Size(400, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Signup(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 23, 65, 24),
            minimumSize: const Size(400, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "SignUp",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
