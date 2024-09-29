import 'package:cultiva/Screens/loginhomescreens.dart/loginhomescreen.dart';
import 'package:flutter/material.dart';

class SignupAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SignupAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loginhomescreen()),
          );
        },
      ),
    );
  }
}
