import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignupButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 23, 65, 24),
        minimumSize: Size(300, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        "Sign Up",
        style: GoogleFonts.judson(
          textStyle: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
